# blade2005 Gentoo overlay

Basics stolen from [lxmx](https://github.com/lxmx/gentoo-overlay) and updated for the current chef version.

Install using [Layman](http://www.gentoo.org/proj/en/overlays/userguide.xml):

```
layman -o https://raw.github.com/blade2005/gentoo-overlay/master/overlay.xml -f -a blade2005
```

## chef

This overlay features a [chef](http://www.opscode.com/chef/install/) adaptation for Gentoo.
To install:

```
echo "app-admin/chef ~amd64" >> /etc/portage/package.keywords
emerge app-admin/chef
```

## chef-server

This overlay features a [chef-server](https://github.com/chef/chef-server) adaptation for Gentoo.
To install:

```
echo "app-admin/chef ~amd64" >> /etc/portage/package.keywords
emerge app-admin/chef
```
