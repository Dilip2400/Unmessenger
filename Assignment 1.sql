/* 1. Identifying users in specific locations (Agra, Maharashtra, West Bengal) */
Select * from post
Where location in ('agra' ,'maharashtra','west bengal');

/* 2. Top 5 most followed hashtags on platform */
Select hashtag_name as 'Hashtags', count(hashtag_follow.hashtag_id) as 'Total no. of Follows' 
from hashtag_follow, hashtags 
Where hashtags.hashtag_id = hashtag_follow.hashtag_id
group by hashtag_follow.hashtag_id
order by count(hashtag_follow.hashtag_id) DESC limit 5;

/* 3. Top 10 most used hashtags */
Select hashtag_name as ' Most used hashtags', 
count(post_tags.hashtag_id) as 'No. of times used' from hashtags,post_tags
Where hashtags.hashtag_id = post_tags.hashtag_id
group by post_tags.hashtag_id
order by count(post_tags.hashtag_id) DESC limit 10;

/* 4. Identifying the most inactive user */
Select user_id, username as 'Most Inactive User' from users
Where user_id not in (select user_id from post);
 
/* 5. Identifying posts with most number of likes */
Select post_likes.user_id, post_likes.post_id, Count(post_likes.post_id) 
From post_likes, post
Where post.post_id = post_likes.post_id 
group by post_likes.post_id
order by count(post_likes.post_id) DESC;

/* 6. Average number of posts per user */
Select Round((count(post_id) / count(Distinct user_id) ),2) as 'Avg no. of Posts per User' from post;

/* 7. no. of logins made by each user */
Select user_id, username, email, login.login_id as logins from users 
Natural join login;

/* 8. Identifying user who liked every post */
Select username, Count(*) as likes_count from users 
inner join post_likes on users.user_id = post_likes.user_id 
group by post_likes.user_id 
having likes_count = (select Count(*) from post); 

/* 9. Users who never commented */
Select user_id, username as 'User who never comment' from users
Where user_id not in (select user_id from comments);

/* 10. User who commented on every post (CHECK FOR BOT) */
Select username, Count(*) as comments_count from users 
inner join comments on users.user_id = comments.user_id 
group by comments.user_id 
having comments_count = (select Count(*) from comments); 

/* 11. User Not Followed by anyone */
Select user_id, username as 'User Not Followed by anyone'
from users
Where user_id not in (select followee_id from follows);

/* 12. To find users who are not following anyone */
Select user_id, username as 'User id not following others' from users
Where user_id not in (select follower_id from follows);

/* 13. To find users who posted more than 5 posts */
Select user_id, count(user_id) as no_of_posts from post
group by user_id
Having no_of_posts > 5
order by count(user_id) DESC;

/* 14. To find users having more than 40 followers */
Select followee_id, count(follower_id) as no_of_followers from follows
group by followee_id
having no_of_followers > 40
order by count(follower_id) DESC;

/* 15. To find comments containing specific words like "good" or "beautiful." (Regular expressions) */
Select * from comments
Where comment_text REGEXP 'good|beautiful';

/* 16. To identify longest captions in posts (Top 5) */
Select user_id, caption, length(post.caption) as len_caption from post
Order by len_caption DESC limit 5;
