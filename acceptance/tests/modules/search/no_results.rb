test_name 'puppet module search should print a reasonable message for no results'

hosts.each do |host|
  skip_test "skip tests requiring forge certs on solaris and aix" if host['platform'] =~ /solaris/
end

module_name   = "module_not_appearing_in_this_forge"

step 'Setup'
stub_forge_on(master)

step "Search for a module that doesn't exist"
on master, puppet("module search #{module_name}") do |res|
  assert_match(/Searching/, res.stdout)
  assert_match(/No results found for '#{module_name}'/, res.stdout)
end
