This Harry Potter app MVC creates a signup and login for students and aministrators at the school. Once logged in, the user can view their respective houses only. In the House view, they can see the names of the other house members, their house's last Quiddich cup, and a link to their houses secret. Different privaleges are allowed to students and administrators. There is a also a separate Cups view where the user can view all of the past Quiddich years of the cups and their winners. There is a Favorites class where the student is asked to input their favorite band and give an optional comment. Students can create read update and delete their favorites. The favorites class has the full restful routes plus an extra route for displaying only the individual students' favorites.
To use this MVC, first run migrations if they are not already migrated, then rake db:seed.