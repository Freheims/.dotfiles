import requests
import os
import json
from rofi import Rofi
import sys


class RofiSkyss:
    def __init__(self):
        self.rofi = Rofi()

        cache_dir = os.path.expanduser('~/.cache/rofi-skyss')
        self.stop_groups_cache = os.path.join(cache_dir, 'stop_groups.json')

        self.api_url = 'https://api.skyss.no/ws/mobile'
        self.api_auth = ('mobile', 'g7pEtkRF@')

        # ensure that the cache dir exists
        os.makedirs(cache_dir, exist_ok=True)


    def call_api(self, endpoint):
        url = '{}/{}'.format(self.api_url, endpoint)
        response = requests.get(url, auth=self.api_auth)
        if response.status_code == 200:
            return response.json()
        else:
            return False


    def get_stop_groups(self):
        if os.path.exists(self.stop_groups_cache):
            with open(self.stop_groups_cache) as f:
                return json.load(f)
        else:
            self.rofi.status('Downloading list of stop groups ...')
            stop_groups = self.call_api('stopgroups')
            if not stop_groups:
                self.rofi.error('Failed to download stop groups, sorry :(')
                sys.exit(1)

            with open(self.stop_groups_cache, 'w') as f:
                json.dump(stop_groups, f)

            self.rofi.close()
            return stop_groups


    def get_stops(self, identifier):
        self.rofi.status('Getting stops and passing times')
        stop_group = self.call_api('stopgroups/' + identifier)
        if not stop_group:
            self.rofi.error('Failed to get stops and passing times, sorry :(')
            sys.exit(1)

        routes = []
        for group in stop_group['StopGroups']:
            for stop in group['Stops']:
                if 'RouteDirections' not in stop:
                    self.rofi.error('The stop group is missing routes, sorry :(')
                    sys.exit(1)
                for route in stop['RouteDirections']:
                    routes.append(route)

        if not routes:
            self.rofi.error('The stop group is missing routes, sorry :(')
            sys.exit(1)

        route_names = ['{} - {}'.format(route['PublicIdentifier'], route['DirectionName']) for route in routes]
        index, status = self.rofi.select('Route: ', route_names)
        if status == 0:
            route = routes[index]
            times = [time['DisplayTime'] for time in route['PassingTimes']]
            self.rofi.select('Time: ', times, '<b>{}</b>'.format(route_names[index]), width=len(route_names[index]) * -1)


    def run(self):
        stop_groups = self.get_stop_groups()['StopGroups']
        stop_group_names = [group['Description'] for group in stop_groups]
        index, status = self.rofi.select('Stop group: ', stop_group_names)
        if status == 0:
            stop_group = stop_groups[index]
            self.get_stops(stop_group['Identifier'])


rofi_skyss = RofiSkyss()
rofi_skyss.run()
