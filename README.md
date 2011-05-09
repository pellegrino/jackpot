Jackpot
==========

WORK IN PROGRESS/ Jackpot is the easiest way to get paid using ruby. It abstracts all the nasty details about billing that every Saas app have to deal with.

My May 2011 RMU project.

## Using jackpot ##

Include jackpot at your model. Typically, you may want to use it at
your users model.


   class User < ActiveRecord::Base
     include Jackpot::Subscription
   end

## Contributing to jackpot  ##

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If
* you want to have your own version, or is otherwise necessary, that
* is fine, but please isolate to its own commit so I can cherry-pick
* around it.




## Copyright ##

Copyright (c) 2011 Vitor Pellegrino. See LICENSE.txt for
further details.

