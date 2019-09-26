# README
 
##### Ruby Version 

* `ruby 2.6.2p47 (2019-03-13 revision 67232) [x86_64-darwin18]`

##### Rails Version 

* `Rails 6.0.0`

##### Configuration

I will advise you use `Chruby` to configure your environment with `Ruby and Rails Versions` I used for this solution before moving forward with the steps below. You can follow `https://medium.com/@hpux/using-chruby-as-the-default-ruby-version-manager-c11346e3cc` for that. When you are done, then you can proceed with the following steps:
1. Clone the repo.
2. Run `EDITOR=vim rails credentials:edit`. This creates `credentials.yml.enc` and `master.key` file for you inside `/config`. For more hint see https://gist.github.com/db0sch/19c321cbc727917bc0e12849a7565af9.
3. Run `bundle install` from the root of the application.


CHALLENGE QUESTIONS
----
##### How did you approach this challenge?

I created a **One-Tier Architecture** application and here is my approach below:

I approached this solution in a way to allow users to clock in multiple events in a day. Records are strictly confined to the current user so that you cannot have access to your colleague's clock event details. Also, clock-in time is set at backend once you hit the button so that users don't have access to edit clock time. Giving that grace for the user to edit time means users are permitted to lie about their clock events which in turns can have a severe cost repercussion. Let me list out the feature here:

1. Users create or clock-in an event.
2. Users can edit only the Purpose of the event.
3. Users can delete the event
4. Users can clock out any event
5. Clocked-out events can be seen at entry-details url with the necessary information to the events which cannot be deleted again. 

##### What schema design did you choose and why?

I used RDMS (Relational Database Management System) approach with lots of integrity rules attached to it. Below are the details to my schema design:

* **Entity Integrity Rule**: I made primary key cannot be NULL, so as to easily match a user with records.

* **Referential Integrity Rule**: This can be referred in Rails as Associations. This allows me to you can only insert a row with a foreign key in the child table only if that value (of the foreign key) exists in the parent table.

* **Business logic integrity**: Validations. This allows the most client facing attribute to be validated by ensuring it is supplied for each event.

  ------- **Indexes**: I indexed my table for easy processing of the application. The most go to columns of a table are indexed for it to respond as fast as possible. I also planed on doing a Search so I indexed all the columns am expecting to search by, but due to time, I didnt touch search however the indexes are way useful for the rendering of the entry details so it is not a waste.  

##### If you were given another day to work on this, how would you spend it? What if you were given a month?

If I have`ANOTHER DAY`, I will implement a search system to search or filter previous entry details.

If I have `ONE MONTH`, this a take a different turn all together. Let me touch of on what I will do differently on that:

- Self-Referential Associations
    
    https://guides.rubyonrails.org/association_basics.html#self-joins 
    
    This will allow me to store all clock_entries in a single database model, but be able to trace relationships such as between it's subordinates.
 
- Schema Design: 

    I will design my schema for ClockEntry-Purpose attribute to be of JSON datatype and when requests happen on the frontend part it saves as json pair, then I can easily pick details render effective overview for admin users with a great performance.

- Three-Tier Architecture

    `Presentation Layer` will standalone; 
    
    `Application Layer` will standalone; and 
    
    `Data Layer` will standalone. 
    
    This allows me to have a solution that cut across multiple devises.
    
- Exception Handling for production use.

    `Exceptions != Error`, so I will handle my own exception the way I did with a separate controller but in a more robust way, because anything that can go wrong will go wrong. 

