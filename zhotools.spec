Name:		zhotools
Version:	0.3
Release:	1%{?dist}
Summary:	Zhongwen Tools
License:	MPL
Group:		Applications/Utilities
Source0:	%{name}-%{version}.tar.gz
BuildArch:	noarch
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root

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
* Wed Mar 02 2011 Wei-Lun Chao <william.chao@ossii.com.tw> 0.1-1.ossii
- Initial package
