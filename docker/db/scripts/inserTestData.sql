-- use airlines;
-- # --
-- -- CourseCategory insert
-- insert into course_category(category_type) values("Matma");
-- insert into course_category(category_type) values("Literatura");
-- insert into course_category(category_type) values("Chemija");
-- -- -- Courses insert
-- -- use seminry;
-- insert into courses( access_level, title, course_category_id) VALUES(1, 'Course o Matma 1',1);
-- insert into courses( access_level, title, course_category_id) VALUES(1, 'Course o Matma 2',1);
-- insert into courses( access_level, title, course_category_id) VALUES(1, 'Course o Matma 2',1);
-- insert into courses( access_level, title, course_category_id) VALUES(2, 'Course o Literatura 1',2);
-- insert into courses( access_level, title, course_category_id) VALUES(2, 'Course o Literatura 2',2);
-- insert into courses( access_level, title, course_category_id) VALUES(2, 'Course o Literatura 3',2);
-- insert into courses( access_level, title, course_category_id) VALUES(3, 'Course o Chemija 1',3);
-- insert into courses( access_level, title, course_category_id) VALUES(3, 'Course o Chemija 2',3);
-- insert into courses( access_level, title, course_category_id) VALUES(3, 'Course o Chemija 3',3);

-- # --
-- -- Lessons insert
-- insert into lesson(course_id, title) values(1,'Lekcja 1');
-- insert into lesson(course_id, title) values(3,'Lekcja 2');
-- insert into lesson(course_id, title) values(2,'Lekcja 3');

-- -- MaterialType insert
-- insert into material_type(material_type) values("Material0");
-- insert into material_type(material_type) values("sound_only");
-- insert into material_type(material_type) values("video_only");
-- insert into material_type(material_type) values("blog_post");
-- -- Material insert
-- insert into material(material_type_id,lesson_id,text,vide_link, sound_link, created_at) values(1,1,"testText", "testVidio", "testSound", null);
-- insert into material(material_type_id,lesson_id,text,vide_link, sound_link, created_at) values(2,2,"testText", NULL, "testSound", null);
-- insert into material(material_type_id,lesson_id,text,vide_link, sound_link, created_at) values(3,3,NULL, "testVidio", "testSound", null);
-- insert into material(material_type_id,lesson_id,text,vide_link, sound_link, created_at) values(4,1,'<p style="text-align: center;"><strong><span style="font-size: 24px;">Witamy w seminry.com! </span></strong></p> <p style="text-align: center;">To właśnie tutaj znajduje się <em>najlepsza&nbsp;</em>przestrzeń <span style="background-color: rgb(247, 218, 100);">do nauki</span> dla os&oacute;b <u>ze specjalnymi potrzebami!</u></p>', "testVidio", "testSound", now());



-- # --
-- -- CourseDetails insert
-- insert into course_details(course_id, course_category_id, course_price) values(1,1,20);
-- insert into course_details(course_id, course_category_id, course_price) values(2,2,30);
-- insert into course_details(course_id, course_category_id, course_price) values(3,3,30);
-- # --
-- -- Newsletter insert
-- insert into newsletter(firstname, email) values ("Aleksandr", "test@test.test");
-- insert into newsletter(firstname, email) values ("Bartosz", "puszkarski.bartosz@gmail.com");
