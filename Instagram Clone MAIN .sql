/*FIND THE 5 OLDEST USERS.*/
SELECT * FROM users 
ORDER BY created_at ASC LIMIT 5;



/*WHAT DAY OF THE WEEK DO MOST USERS REGISTER ON?*/
SELECT DATE_FORMAT(created_at, "%W") AS `DAY`, COUNT(DATE_FORMAT(created_at, "%W"))
FROM users
GROUP BY `DAY` 
ORDER BY COUNT(DATE_FORMAT(created_at, "%W")) DESC;



/*FIND THE USERS WHO HAVE NEVER POSTED A PHOTO*/
SELECT users.id, users.username FROM users
LEFT JOIN photos ON users.id=photos.user_id
WHERE photos.user_id IS NULL
GROUP BY users.id;



/*WHO HAS THE MAXIMUM LIKES ON A SINGLE PHOTO??!!*/
SELECT username, photos.id, photos.image_url,  COUNT(*) AS total FROM photos
JOIN likes ON likes.photo_id = photos.id
JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC;



/*HOW MANY TIMES DOES THE AVERAGE USER POST?*/
/*total number of photos/total number of users*/
SELECT ROUND((SELECT COUNT(*) FROM photos ) / ( SELECT COUNT(*) FROM users ),2) AS `Average Number of posts by a user`;



/*USER RANKING BY POSTINGS HIGHER TO LOWER*/  
SELECT users.id, username, COUNT(photos.id) AS `Number of posts` FROM users
JOIN photos ON users.id=photos.user_id
GROUP BY users.id, users.username
ORDER BY COUNT(photos.id) DESC;



/*TOTAL NUMBERS OF USERS WHO HAVE POSTED AT LEAST ONE TIME*/ 
SELECT COUNT(DISTINCT(photos.user_id)) FROM photos;



 /*TOP 5 MOST COMMONLY USED HASHTAGS*/
SELECT tag_id, tags.tag_name, COUNT(tag_id)
FROM photo_tags
LEFT JOIN tags ON photo_tags.tag_id=tags.id
GROUP BY tag_id
ORDER BY COUNT(tag_id) DESC;



/*ELIMINATING BOTS FROM THE SITE
-- Find users who have liked every single photo on the site*/ 
SELECT users.id, users.username FROM users
RIGHT JOIN likes ON likes.user_id=users.id
GROUP BY users.id, users.username
HAVING COUNT(users.id)=(SELECT COUNT(distinct(photo_id)) FROM LIKES);



/*FIND USERS WHO HAVE NEVER COMMENTED ON A PHOTO*/
SELECT users.id, username FROM users
LEFT JOIN comments ON comments.user_id = users.id
WHERE comment_text IS NULL
GROUP BY users.id;



-- /*FIND USERS WHO HAVE COMMENTED ON EVERY PHOTO*/
SELECT user_id, users.username FROM comments
JOIN users ON users.id=comments.user_id
GROUP BY user_id HAVING COUNT(*) = (SELECT COUNT(*) FROM comments);



-- /*FIND USERS WHO COMMENTED ON A PHOTO ANYTIME IN THE PAST*/
SELECT users.id, username FROM users
JOIN comments ON users.id=comments.user_id
GROUP BY user_id;