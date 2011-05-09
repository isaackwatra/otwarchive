@users
Feature: Edit preferences
  In order to have an archive full of users
  As a humble user
  I want to fill out my preferences

  Scenario: View and edit preferences - viewing history, personal details, view entire work

  Given the following activated user exists
    | login         | password   |
    | editname      | password   |
  When I go to editname's user page
    And I follow "Profile"
  Then I should not see "My email address"
    And I should not see "My birthday"
  When I am logged in as "editname" with password "password"
  Then I should see "Hi, editname!"
    And I should see "Log out"
  When I post the work "This has two chapters"
  And I follow "Add Chapter"
    And I fill in "content" with "Secondy chapter"
    And I press "Preview"
    And I press "Post Chapter"
  Then I should not see "Secondy chapter"
  When I follow "editname"
  Then I should see "My Dashboard"
    And I should see "My History"
    And I should see "My Preferences"
    And I should see "Profile"
  When I follow "My Preferences"
  Then I should see "Update My Preferences"
    And I should see "Edit My Profile"
    And I should see "Orphan My Works"
  When I follow "Edit My Profile"
  Then I should see "Change My Password"
  When I follow "editname"
  Then I should see "My Dashboard"
  When I follow "Profile"
  Then I should see "Set My Preferences"
  When I follow "Set My Preferences"
  Then I should see "Update My Preferences"
    And I should see "Edit My Profile"
  When I uncheck "Enable Viewing History"
    And I check "Always view entire work by default"
    And I check "Display Email Address"
    And I check "Display Date of Birth"
    And I press "Update"
  Then I should see "Your preferences were successfully updated"
  When I follow "editname"
  Then I should see "My Dashboard"
    And I should not see "My History"
  When I go to the works page
    And I follow "This has two chapters"
  Then I should see "Secondy chapter"
  When I follow "Log out"
    And I go to editname's user page
    And I follow "Profile"
  Then I should see "My email address"
    And I should see "My birthday"
  When I go to the works page
    And I follow "This has two chapters"
  Then I should not see "Secondy chapter"

  Scenario: View and edit preferences - show/hide warnings and tags

  # set preference
  Given the following activated users exist
    | login          | password   |
    | mywarning1     | password   |
    | mywarning2     | password   |
    And a fandom exists with name: "Stargate SG-1", canonical: true
  When I am logged in as "mywarning1" with password "password"
  When I post the work "This work has warnings and tags" with fandom "Stargate SG-1, Stargate SG-2"
    And I follow "Edit"
    And I check "series-options-show"
    And I fill in "work_series_attributes_title" with "My new series"
    And I press "Preview"
    And I press "Update"
  Then I should see "Work was successfully updated"
  When I follow "Log out"
  When I am logged in as "mywarning2" with password "password"
    And I post the work "This also has warnings and tags" with fandom "Stargate SG-1, Stargate SG-2" with freeform "Scarier"
  When I view the work "This work has warnings and tags"
    And I follow "Bookmark"
    And I press "Create"
  Then I should see "Bookmark was successfully created"
  When I follow "This work has warnings and tags"
    And I follow "My new series"
    And I follow "Bookmark"
    And I press "Create"
  Then I should see "Bookmark was successfully created"

  # see everything on works index and show page
  When I go to the works page
  Then I should see "No Archive Warnings Apply"
    And I should not see "Show warnings"
    And I should see "Scary tag"
    And I should not see "Show additional tags"
  When I follow "This work has warnings and tags"
  Then I should see "No Archive Warnings Apply" within ".warning"
    And I should not see "Show warnings"
    And I should see "Scary tag"
    And I should not see "Show additional tags"
  When I go to the works page
    And I follow "This also has warnings and tags"
  Then I should see "No Archive Warnings Apply" within ".warning"
    And I should not see "Show warnings"
    And I should see "Scarier"
    And I should not see "Show additional tags"

  # see everything on fandoms page, for both canonical and unwrangled fandoms, and bookmarks page and series page
  When I follow "fandoms"
  Then I should see "Stargate SG-1"
    And I should see "Stargate SG-2"
  When I follow "Stargate SG-1"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".tags"
    And I should not see "Show warnings"
    And I should see "Scary tag"
    And I should see "Scarier"
    And I should not see "Show additional tags"
  When I follow "fandoms"
    And I follow "Stargate SG-2"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".tags"
    And I should not see "Show warnings"
    And I should see "Scary tag"
    And I should see "Scarier"
    And I should not see "Show additional tags"
  When I follow "bookmarks"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".tags"
    And I should not see "Show warnings"
    And I should see "Scary tag"
    And I should not see "Scarier"
    And I should not see "Show additional tags"
  When I follow "My new series"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".tags"
    And I should not see "Show warnings"
    And I should see "Scary tag"
    And I should not see "Scarier"
    And I should not see "Show additional tags"

  # change preference to hide warnings
  When I follow "mywarning2"
  Then I should see "My Dashboard"
  When I follow "My Preferences"
  Then I should see "Update My Preferences"
  When I check "Hide warnings"
    And I press "Update"
  Then I should see "Your preferences were successfully updated"

  # hidden warnings on works index and show page, except for your own works
  When I go to the works page
  Then I should see "No Archive Warnings Apply"
    And I should see "Show warnings"
    And I should see "Scary tag"
    And I should see "Scarier"
    And I should not see "Show additional tags"
  When I follow "This work has warnings and tags"
  Then I should not see "No Archive Warnings Apply" within ".warning"
    And I should see "Show warnings"
    And I should see "Scary tag"
    And I should not see "Show additional tags"
  When I go to the works page
    And I follow "This also has warnings and tags"
  Then I should see "No Archive Warnings Apply" within ".warning"
    And I should not see "Show warnings"
    And I should see "Scarier"
    And I should not see "Show additional tags"

  # hidden warnings on fandoms page and bookmarks page, except for your own works, for both canonical and unwrangled fandoms
  When I follow "fandoms"
  Then I should see "Stargate SG-1"
  When I follow "Stargate SG-1"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".own .tags"
    # TODO: Figure out how to make this work
    # And I should not see "No Archive Warnings Apply" within ".tags" that isn't .own
    And I should see "Show warnings"
    And I should see "Scary tag"
    And I should see "Scarier"
    And I should not see "Show additional tags"
  When I follow "fandoms"
    And I follow "Stargate SG-2"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
  When "issue 1904" is fixed
    # And I should not see "No Archive Warnings Apply"
    # And I should see "Show warnings"
  Then I should see "Scary tag"
    And I should see "Scarier"
    And I should not see "Show additional tags"
  When I follow "bookmarks"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should not see "No Archive Warnings Apply" within ".tags"
    And I should see "Show warnings"
    And I should see "Scary tag"
    And I should not see "Scarier"
    And I should not see "Show additional tags"
  When I follow "My new series"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should not see "No Archive Warnings Apply" within ".tags"
    And I should see "Show warnings"
    And I should see "Scary tag"
    And I should not see "Scarier"
    And I should not see "Show additional tags"

  # change preference to hide freeforms
  When I follow "mywarning2"
    And I follow "My Preferences"
    And I check "Hide freeform tags"
    And I press "Update"
  Then I should see "Your preferences were successfully updated"

  # hidden both on works index and show page, except for your own works
  When I go to the works page
  Then I should see "No Archive Warnings Apply"
    And I should see "Show warnings"
    And I should not see "Scary tag"
    And I should see "Scarier"
    And I should see "Show additional tags"
  When I follow "This work has warnings and tags"
  Then I should not see "No Archive Warnings Apply" within ".warning"
    And I should see "Show warnings"
    And I should not see "Scary tag"
    And I should see "Show additional tags"
  When I go to the works page
    And I follow "This also has warnings and tags"
  Then I should see "No Archive Warnings Apply" within ".warning"
    And I should not see "Show warnings"
    And I should see "Scarier"
    And I should not see "Show additional tags"

  # hidden both on fandoms page and bookmarks page, except for your own works, for both canonical and unwrangled fandoms
  When I follow "fandoms"
  Then I should see "Stargate SG-1"
  When I follow "Stargate SG-1"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".own .tags"
    # TODO: Figure out how to make this work
    # And I should not see "No Archive Warnings Apply" within ".tags" when it's not ".own"
    And I should see "Show warnings"
    # TODO: Figure out how to make this work
    And I should not see "Scary tag"
    And I should see "Scarier"
    And I should see "Show additional tags"
  When I follow "fandoms"
    And I follow "Stargate SG-2"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
  When "issue 1904" is fixed
    # And I should not see "No Archive Warnings Apply" within ".tags"
    # And I should see "Show warnings"
  Then I should not see "Scary tag"
    And I should see "Scarier"
    And I should see "Show additional tags"
  When I follow "bookmarks"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should not see "No Archive Warnings Apply" within ".tags"
    And I should see "Show warnings"
    And I should not see "Scary tag"
    And I should not see "Scarier"
    And I should see "Show additional tags"
  When I follow "My new series"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should not see "No Archive Warnings Apply" within ".tags"
    And I should see "Show warnings"
    And I should not see "Scary tag"
    And I should not see "Scarier"
    And I should see "Show additional tags"

  # change preference to show warnings, keep freeforms hidden
  When I follow "mywarning2"
    And I follow "My Preferences"
    And I uncheck "Hide warnings"
    And I press "Update"
  Then I should see "Your preferences were successfully updated"

  # hidden only freeforms on works index and show page, except for your own works
  When I go to the works page
  Then I should see "No Archive Warnings Apply"
    And I should not see "Show warnings"
    And I should not see "Scary tag"
    And I should see "Scarier"
    And I should see "Show additional tags"
  When I follow "This work has warnings and tags"
  Then I should see "No Archive Warnings Apply" within ".warning"
    And I should not see "Show warnings"
    And I should not see "Scary tag"
    And I should see "Show additional tags"
  When I go to the works page
    And I follow "This also has warnings and tags"
  Then I should see "No Archive Warnings Apply" within ".warning"
    And I should not see "Show warnings"
    And I should see "Scarier"
    And I should not see "Show additional tags"

  # hidden only freeforms on fandoms page and bookmarks page, except for your own works, for both canonical and unwrangled fandoms
  When I follow "fandoms"
  Then I should see "Stargate SG-1"
  When I follow "Stargate SG-1"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".tags"
    And I should not see "Show warnings"
    And I should not see "Scary tag"
    And I should see "Scarier"
    And I should see "Show additional tags"
  When I follow "fandoms"
    And I follow "Stargate SG-2"
  Then I should see "This work has warnings and tags"
    And I should see "This also has warnings and tags"
  When "issue 1904" is fixed
    # And I should see "No Archive Warnings Apply" within ".tags"
    # And I should not see "Show warnings"
  Then I should not see "Scary tag"
    And I should see "Scarier"
    And I should see "Show additional tags"
  When I follow "bookmarks"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".tags"
    And I should not see "Show warnings"
    And I should not see "Scary tag"
    And I should not see "Scarier"
    And I should see "Show additional tags"
  When I follow "My new series"
  Then I should see "This work has warnings and tags"
    And I should not see "This also has warnings and tags"
    And I should see "No Archive Warnings Apply" within ".tags"
    And I should not see "Show warnings"
    And I should not see "Scary tag"
    And I should not see "Scarier"
    And I should see "Show additional tags"
