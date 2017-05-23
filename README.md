# WatirInstall

This gem allows you to create a new directory for your project with sample templates
to use to write your Watir tests. It includes a number of useful gems along with 
the recommended default configurations to easily create and maintain your test suite.

## Installation

    $ gem install watir_install

## Usage

#### Create a new project

    $ watir new project_name

    or

    $ watir new project_name --no_git true

#### Generate Test

    $ watir generate test DataName
    
    or
    
    $ watir generate test DataName test1 test2 test3 test4


#### Generate Data

    $ watir generate data DataName
    
    or
    
    $ watir generate data DataName key1 key2 key3 key4


#### Generate Page

    $ watir generate page PageName
    
    or
    
    $ watir generate page PageName el1 el2 el3 el4
    
    or
    
    $ watir generate page PageName --url http://example.com

    or
    
    $ watir generate page PageName:DataName key1 key2 key3 key4 --form true

    or

    $ watir generate page PageName:DataName key1 key2 key3 key4 --form true --url http://example.com

#### Generate Scaffolding

    $ watir generate scaffold ObjectName el1 el2 el3 el4 --url http://example.com/object

## See Example Project

    $ watir example

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/titusfortner/watir_install.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## TODO

1. Support Camel Case project names
2. Add Watir-Scroll
