-- --Formatting
-- .mode column
-- .header on

-- create tables

CREATE TABLE organization (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(64) NOT NULL UNIQUE, created TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(64) NOT NULL UNIQUE, username VARCHAR(32) NOT NULL UNIQUE, created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE channel(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(64) NOT NULL UNIQUE, organization_id INTEGER REFERENCES organization(id), created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE message (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, user_id INTEGER REFERENCES user(id), channel_id INTEGER REFERENCES channel(id), created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE user_channel(user_id INTEGER REFERENCES user(id), channel_id INTEGER REFERENCES channel(id));

--list all organization names
--SELECT name from organization;
-- name         
-------------
-- Lambda School


--list all channel names
--SELECT name from channel;
-- name  
-- #general  
-- #help     


--list all channels in a specific org by org name
-- SELECT channel.name FROM channel, organization WHERE organization_id = organization.id AND organization.name = "Lambda School";
-- name      
----------
-- #general 

--list all messages in a specific channel by channel name #general in order of post_time, descending
-- SELECT content FROM message WHERE channel_id IS (SELECT id FROM channel WHERE name IS '#general') ORDER BY created DESC;
-- content       
--------------
-- Morning guys.
-- Happy last day of class!
-- Thanks for your help.

--list all channels to which Alice belongs
-- SELECT channel.name, channel.id FROM channel INNER JOIN user_channel AS uc ON channel.id IS uc.channel_id INNER JOIN user ON user.id IS uc.user_id WHERE user.name IS "Alice";
--------------
-- #general|1
-- #random|2

--list all users that belong to channel general
-- SELECT user.name FROM user INNER JOIN user_channel ON user.id IS user_channel.user_id INNER JOIN channel ON user_channel.channel_id IS channel.id WHERE channel.name IS "#general";
-- name      
----------
-- Alice
-- Bob

--list all messages in all channels by user Alice
-- SELECT content FROM message INNER JOIN user ON message.user_id IS user.id WHERE user.name IS "Alice";
-- content                       
----------
-- Happy Friday
-- Happy last day of class!

--list all messages in #random by user Bob
--SELECT content FROM message WHERE channel_id IS(SELECT id FROM channel WHERE name is "#random") AND user_id IS (SELECT id FROM user WHERE name is "Bob");
-- content   
----------
-- Can we go over that again?

--list count of messages across all channels per user
--SELECT COUNT(user.id), user.name FROM message INNER JOIN user ON message.user_id IS user.id INNER JOIN channel WHERE message.channel_id IS channel.id GROUP BY user.id;
----------
-- 2|Alice
-- 2|Bob
-- 2|Chris


--STRETCH: list count of messages per user per channel
--SELECT COUNT(message.id), user.name, channel.name FROM message, user, channel WHERE message.user_id = user.id AND message.channel_id = channel.id GROUP BY message.user_id HAVING COUNT(message.id) > 0;
----------
-- 2|Alice|#general
-- 2|Bob|#random
-- 2|Chris|#general

