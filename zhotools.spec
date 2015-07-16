Name:		zhotools
Version:	0.4
Release:	1%{?dist}
Summary:	Zhongwen Tools
License:	MPL
Group:		Applications/Utilities
Source0:	%{name}-%{version}.tar.gz
BuildArch:	noarch
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root
BuildRequires:  sqlite
Requires:  sqlite

%description
Using Zhongwen tables for searching, converting
and other various purposes.

%prep
%setup -q

%build
%__make

%install
%__rm -rf %{buildroot}
%__make DESTDIR=%{buildroot} install

%clean
%__rm -rf %{buildroot}

%files
%defattr(-,root,root)
%doc README COPYING
%{_datadir}/%{name}
%{_bindir}/*

%changelog
* Thu Jan 31 2013 Robert Wei <robert.wei@ossii.com.tw> 0.4-1.ossii
- Using sqlite3

* Wed Mar 02 2011 Wei-Lun Chao <william.chao@ossii.com.tw> 0.1-1.ossii
- Initial package
