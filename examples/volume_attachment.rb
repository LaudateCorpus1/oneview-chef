# (c) Copyright 2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

my_client = {
  url: ENV['ONEVIEWSDK_URL'],
  user: ENV['ONEVIEWSDK_USER'],
  password: ENV['ONEVIEWSDK_PASSWORD'],
  api_version: 800
}

vol_attach_properties = {
  description: 'Volume attachment',
  isShareable: true,
  provisioningType: 'Thin',
  size: 1024 * 1024 * 1024 # 1GB
}

# Example: Create a volume attachment
oneview_volume_attachment 'VolumeAttachment1' do
  client my_client
  data(vol_attach_properties)
  action :create_if_missing
end

# Example: Update a volume attachment
oneview_volume_attachment 'VolumeAttachment1' do
  client my_client
  data(description: 'Volume attachment Updated')
end

# Example: Repair a volume
oneview_volume 'VolumeAttachment1' do
  client my_client
  action :repair
end
