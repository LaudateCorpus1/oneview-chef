require_relative './../../../spec_helper'

describe 'oneview_test_api300_synergy::logical_switch_add_to_scopes' do
  let(:resource_name) { 'logical_switch' }
  include_context 'chef context'

  let(:scope1) { OneviewSDK::API300::C7000::Scope.new(client, name: 'Scope1', uri: '/rest/fake/1') }
  let(:scope2) { OneviewSDK::API300::C7000::Scope.new(client, name: 'Scope2', uri: '/rest/fake/2') }

  before do
    allow(OneviewSDK::API300::C7000::Scope).to receive(:new).and_return(scope1, scope2)
    allow(scope1).to receive(:retrieve!).and_return(true)
    allow(scope2).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:retrieve!).and_return(true)
    allow_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:[]).and_call_original
  end

  it 'adds all scopes when are not added' do
    allow_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:[]).with('scopeUris').and_return([])
    expect_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:add_scope).with(scope1)
    expect_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:add_scope).with(scope2)
    expect(real_chef_run).to add_oneview_logical_switch_to_scopes('LogicalSwitch1')
  end

  it 'adds only the scope that is not added' do
    allow_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:[]).with('scopeUris').and_return(['/rest/fake/1'])
    expect_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).not_to receive(:add_scope).with(scope1)
    expect_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:add_scope).with(scope2)
    expect(real_chef_run).to add_oneview_logical_switch_to_scopes('LogicalSwitch1')
  end

  it 'does nothing when scopes are already added' do
    allow_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).to receive(:[]).with('scopeUris').and_return(['/rest/fake/1', '/rest/fake/2'])
    expect_any_instance_of(OneviewSDK::API300::C7000::LogicalSwitch).not_to receive(:add_scope)
    expect(real_chef_run).to add_oneview_logical_switch_to_scopes('LogicalSwitch1')
  end
end
