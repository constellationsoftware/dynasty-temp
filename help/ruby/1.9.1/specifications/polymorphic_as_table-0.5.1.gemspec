# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{polymorphic_as_table}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jeremiah Dodds}]
  s.date = %q{2011-08-26}
  s.description = %q{Monkey-patches ActiveRecord so that polymorphic associations have their type
column data written as their tablenames instead of their classnames. Intended
primarily for use in supporting legacy databases.
}
  s.email = %q{jeremiah.dodds@gmail.com}
  s.extra_rdoc_files = [%q{README.rdoc}]
  s.files = [%q{README.rdoc}]
  s.homepage = %q{https://github.com/jdodds/polymorphic_as_table}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Allow for ActiveRecord polymorphic assocations that write their table name as their type}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
