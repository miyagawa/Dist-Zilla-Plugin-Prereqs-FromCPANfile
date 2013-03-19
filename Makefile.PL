use inc::Module::Install;
all_from 'lib/Dist/Zilla/Plugin/Prereqs/FromCPANfile.pm';
readme_from('lib/Dist/Zilla/Plugin/Prereqs/FromCPANfile.pm');
build_requires 'Test::More', 0.88;
test_requires 'Test::Requires';
auto_set_repository();
resources
  homepage      => "https://github.com/miyagawa/Dist-Zilla-Plugin-Prereqs-FromCPANfile",
  bugtracker    => "https://github.com/miyagawa/Dist-Zilla-Plugin-Prereqs-FromCPANfile/issues";
auto_provides;
WriteAll;
