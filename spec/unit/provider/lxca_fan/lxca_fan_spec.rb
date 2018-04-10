################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2016.
#
# LIMITED AND RESTRICTED RIGHTS NOTICE:
# If data or software is delivered pursuant a General Services
# Administration (GSA) contract, use, reproduction, or disclosure
# is subject to restrictions set forth in Contract No. GS-35F-05925.
#-------------------------------------------------------------
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

require 'spec_helper'

describe Puppet::Type.type(:lxca_fan).provider(:lxca_fan) do
  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_fan).stubs(:defaultprovider).returns described_class
  end

  let :fan do
    Puppet::Type.type(:lxca_fan).new(
      name: 'lxca_fan',
      host: 'https://10.243.10.75',
      port: '443',
      login_user: 'Admin',
      login_password: 'Lenovo123',
      verify_ssl: 'NONE',
    )
  end

  let :fan_with_chassis do
    Puppet::Type.type(:lxca_fan).new(
      name: 'lxca_fan',
      host: 'https://10.243.10.75',
      port: '443',
      login_user: 'Admin',
      login_password: 'Lenovo123',
      verify_ssl: 'NONE',
      chassis: 'F44E92339683385A8D97CD6348A6F45F',
    )
  end

  let :fan_with_uuid do
    Puppet::Type.type(:lxca_fan).new(
      name: 'lxca_fan',
      host: 'https://10.243.10.75',
      port: '443',
      login_user: 'Admin',
      login_password: 'Lenovo123',
      verify_ssl: 'NONE',
      uuid: 'FA59C0BBC43C3C15B9D72B94AFF52B91',
    )
  end

  describe 'provider instance type' do
    it 'without uuid and chassis should be an instance of provider ruby' do
      expect(fan.provider).to be_an_instance_of Puppet::Type.type(:lxca_fan).provider(:lxca_fan)
    end
    it 'with chassis should be an instance of provider ruby' do
      expect(fan_with_chassis.provider).to be_an_instance_of Puppet::Type.type(:lxca_fan).provider(:lxca_fan)
    end
    it 'with uuid should be an instance of provider ruby' do
      expect(fan_with_uuid.provider).to be_an_instance_of Puppet::Type.type(:lxca_fan).provider(:lxca_fan)
    end
  end

  describe 'for ensurable filter_by_chassis' do
    it 'has chassis as a parameter' do
      expect { fan.provider.filter_by_chassis }.to raise_error(Puppet::Error, %r{Attribute chassis is mandatory for the ensurable filter_by_chassis})
    end
  end

  describe 'for ensurable filter_by_uuid' do
    it 'has uuid as a parameter' do
      expect { fan.provider.filter_by_uuid }.to raise_error(Puppet::Error, %r{Attribute uuid is mandatory for the ensurable filter_by_uuid})
    end
  end

  describe 'for discover_all' do
    it 'returns an array as a result' do
      expect(fan.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe 'for filter_by_chassis' do
    it 'returns an array as a result' do
      expect(fan_with_chassis.provider.filter_by_chassis).to be_instance_of(Array)
    end
  end

  describe 'for filter_by_uuid' do
    it 'returns an array as a result' do
      expect(fan_with_uuid.provider.filter_by_uuid).to be_instance_of(Array)
    end
  end
end
