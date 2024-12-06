use zchua2;
drop table if exists UserVisibility;
drop table if exists PostLikes;
drop table if exists Posts;
drop table if exists User;

create table User (
userID int auto_increment unique not null,
userName varchar(255) unique not null,
userPassword varchar(255) not null,
isAdmin bool default false,
primary key (userID)
);

create table Posts (
postID int auto_increment unique not null,
userID int not null,
postContent text not null,
postTime datetime not null,
primary key (postID),
foreign key (userID) references User(userID)
);

CREATE TABLE UserVisibility (
    userID INT NOT NULL,
    visibleUserID INT NOT NULL,
    PRIMARY KEY (userID, visibleUserID),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (visibleUserID) REFERENCES User(userID)
);

CREATE TABLE PostLikes (
    postID INT NOT NULL,
    userID INT NOT NULL,
    PRIMARY KEY (postID, userID),
    FOREIGN KEY (postID) REFERENCES Posts(postID),
    FOREIGN KEY (userID) REFERENCES User(userID)
);



insert into User(userID,userName,userPassword)
values (1,"Alice","Alice123"),
(2,"Bob","Bob123"),
(3,"Crystal","Crystal123");
insert into User(userID,userName,userPassword,isAdmin)
values (4,"David","David123", 1);

insert into Posts(userID,postContent,postTime)
values (1, "When's the project due?", '2024-11-20 19:00:00'),
(2, "After Thanksgiving", '2024-11-20 19:01:00'),
(4, "Great job, me", '2024-11-21 09:00:00'),
(1, "Lab this week?", '2024-11-25 10:30:00'),
(3, "Nope", '2024-11-25 10:35:00');

-- Alice's visibility list contains Bob and Crystal
INSERT INTO UserVisibility (userID, visibleUserID) VALUES
    (1, 2), -- Bob
    (1, 3); -- Crystal

-- Bob's visibility list contains Alice and Crystal
INSERT INTO UserVisibility (userID, visibleUserID) VALUES
    (2, 1), -- Alice
    (2, 3); -- Crystal

-- Crystal's visibility list contains Alice
INSERT INTO UserVisibility (userID, visibleUserID) VALUES
    (3, 1); -- Alice


