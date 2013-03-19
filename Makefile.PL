use inc::Module::Install;
all_from 'lib/Dist/Zilla/Plugin/Prereqs/FromCPANfile.pm';
readme_from('lib/Dist/Zilla/Plugin/Prereqs/FromCPANfile.pm');

requires 'Module::CPANfile', 0.9010;
requires 'Dist::Zilla', 4;
requires 'Try::Tiny', 0.10;

build_requires 'Test::More', 0.88;
test_requires 'Test::Requires';
auto_set_repository();
resources
  homepage      => "https://github.com/miyagawa/Dist-Zilla-Plugin-Prereqs-FromCPANfile",
  bugtracker    => "https://github.com/miyagawa/Dist-Zilla-Plugin-Prereqs-FromCPANfile/issues";
auto_provides;
WriteAll;
