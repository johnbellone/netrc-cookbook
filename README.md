netrc-cookbook
==============
![Release](http://img.shields.io/github/release/johnbellone/netrc-cookbook.svg)
[![Build Status](http://img.shields.io/travis/johnbellone/netrc-cookbook.svg)][4]
[![Code Coverage](http://img.shields.io/coveralls/johnbellone/netrc-cookbook.svg)][5]

Provides ability to manage netrc files for users with Chef.

## Attributes
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['netrc']['bag_name']</tt></td>
    <td>String</td>
    <td>Bag name to find Chef Vault items.</td>
    <td><tt>netrc</tt></td>
  </tr>
  <tr>
    <td><tt>['netrc']['users']</tt></td>
    <td>Array</td>
    <td>Users to install netrc from Chef Vault.</td>
    <td><tt>[]</tt></td>
  </tr>
</table>

## Usage

### netrc::default
The default recipe will install the [netrc gem][1] as well as include
the [Chef Vault][2] and [Chef Sugar][3] cookbooks. If the
`node['netrc']['users']` attribute has been set it will use the LWRP
to create a netrc file for the specified user.

## Data Bag
```json
{
    "id": "jbellone",
    "test": {
        "machines": [
            {
                "host": "github.com",
                "login": "johnbellone",
                "password": "bacon"
            }
        ]
    },
    "beta-us-east-1": {
        "machines": []
    }
    "prod-us-east-1": {
        "machines": []
    }
}
```

## LWRP
The resource provider can be used on its own if you are storing your
secret credentials in a separate data bag. Here's an example of a simple
data bag which stores the username and access token for a GitHub user.

```ruby
item = chef_vault_item('secrets', 'github')
netrc 'jbellone' do
  host 'github.com'
  login item['username']
  password item['access_token']
end
```

The bag item for this example would look like:
```json
{
    "id": "github",
    "username": "johnbellone",
    "access_token": "bacon"
}
```

[1]: https://rubygems.org/gems/netrc
[2]: https://supermarket.chef.io/cookbooks/chef-vault
[3]: https://supermarket.chef.io/cookbooks/chef-sugar
[4]: http://travis-ci.org/johnbellone/netrc-cookbook
[5]: https://coveralls.io/r/johnbellone/netrc-cookbook
