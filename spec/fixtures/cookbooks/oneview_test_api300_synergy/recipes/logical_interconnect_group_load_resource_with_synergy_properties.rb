#
# Cookbook Name:: oneview_test_api300_synergy
# Recipe:: logical_interconnect_group_load_resource_with_synergy_properties
#
# (c) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.
#

oneview_logical_interconnect_group 'LogicalInterconnectGroup5' do
    client node['oneview_test']['client']
    interconnects [
      { bay: 3, type: 'TestType1', enclosure_index: 1 },
      { bay: 6, type: 'TestType2', enclosure_index: 1 },
      { bay: 3, type: 'TestType2', enclosure_index: 2 },
      { bay: 6, type: 'TestType1', enclosure_index: 2 }
    ]
    uplink_sets [
      {
        data: {
          name: 'UplinkSet1',
          networkType: 'Ethernet',
          ethernetNetworkType: 'Tagged'
        },
        connections: [
          { bay: 3, port: 'Q1', type: 'TestType1', enclosure_index: 1 },
          { bay: 6, port: 'Q1', type: 'TestType1', enclosure_index: 2 }
        ],
        networks: ['EthernetNetwork1']
      },
      {
        data: {
          name: 'UplinkSet2',
          networkType: 'FibreChannel'
        },
        connections: [
          { bay: 3, port: 'Q2', type: 'TestType1', enclosure_index: 1 },
          { bay: 6, port: 'Q2', type: 'TestType1', enclosure_index: 2 }
        ],
        networks: ['FCNetwork1']
      }
    ]
    action :create
end
