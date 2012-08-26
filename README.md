opinion_socket
==============

Opinion Socket is a software package that is designed to help with gauging the
opinion of a large number of people over the internet.

It was originally designed to make it possible to collect the opinion of
students at IIT Mandi on various issues.

Usage
-----

1. Create a new poll, by running `rake new_poll[Poll Title]` and then editing
the file created in the polls/ directory to add details.
2. Send out emails to all students registered by their enrollment numbers in 
enrollments.yaml by running `rake send_emails[Poll Title]`.
3. Give people some time to fill out the form.
4. Run `rake generate_csv` to generate a CSV file with the results of the poll.
This file can be opened using any spreadsheet software package.

License
-------

This software package is licensed under the three-clause BSD license.
