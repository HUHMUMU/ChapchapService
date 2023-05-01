DROP DATABASE CHAPCHAP;
CREATE DATABASE CHAPCHAP;

use CHAPCHAP;

CREATE TABLE store_manages
(
    store_id     VARCHAR(255) primary key  NOT NULL COMMENT '사장아이디',
    pw           VARCHAR(255)              NOT NULL COMMENT '사장비밀번호',
    business_num VARCHAR(255)              NOT NULL COMMENT '사업자번호',
    store_call   VARCHAR(255)              NOT NULL COMMENT '가게전화번호',
    phone        VARCHAR(255)              NOT NULL COMMENT '사장전화번호',
    email        VARCHAR(255)              NOT NULL COMMENT '사장이메일',
    store_num    INT auto_increment UNIQUE NOT NULL COMMENT '가게고유번호'
);

CREATE TABLE stores
(
    store_num         INT primary key        NOT NULL COMMENT '가게고유번호',
    store_name        VARCHAR(255)           NOT NULL COMMENT '가게이름',
    detail_info       VARCHAR(255)           NOT NULL COMMENT '가게디테일설명',
    short_info        VARCHAR(255)           NOT NULL COMMENT '가게한줄설명',
    madein            VARCHAR(255)           NOT NULL COMMENT '원산지표시',
    address           VARCHAR(255)           NOT NULL COMMENT '가게주소',
    main_img          VARCHAR(255)           NULL COMMENT '대표사진',
    opentime          VARCHAR(255)           NOT NULL COMMENT '영업시간',
    lastorder         VARCHAR(255)           NULL COMMENT '라스트오더',
    waiting_closetime VARCHAR(255)           NULL COMMENT '웨이팅마감시간',
    blogurl           VARCHAR(255)           NULL COMMENT '블로그url',
    youtubeurl        VARCHAR(255)           NULL COMMENT '유튜브url',
    facebookurl       VARCHAR(255)           NULL COMMENT '페북url',
    instaurl          VARCHAR(255)           NULL COMMENT '인스타url',
    tvshow            VARCHAR(255)           NULL COMMENT '방송출연정보직접입력',
    s_rstatus         ENUM ('공개','심사','비공개') NOT NULL DEFAULT '공개' COMMENT '신고상태',
    parking           BOOLEAN                NOT NULL COMMENT '주차장',
    wifi              BOOLEAN                NOT NULL COMMENT '와이파이',
    toilet            BOOLEAN                NOT NULL COMMENT '화장실구분',
    smokingroom       BOOLEAN                NOT NULL COMMENT '흡연실',
    babychair         BOOLEAN                NOT NULL COMMENT '애기의자',
    FOREIGN KEY (store_num) REFERENCES store_manages (store_num)
);

CREATE TABLE users
(
    user_id          VARCHAR(255) primary key unique                NOT NULL COMMENT '유저아이디',
    nickname         VARCHAR(255) unique                            NOT NULL COMMENT '유저닉네임',
    pw               VARCHAR(255)                                   NOT NULL COMMENT '비밀번호',
    name             VARCHAR(255)                                   NOT NULL COMMENT '이름',
    birth            DATE                                           NOT NULL COMMENT '생년월일',
    gender           ENUM ('MALE', 'FEMALE')                        NOT NULL COMMENT '성별',
    address          VARCHAR(255)                                   NOT NULL COMMENT '주소',
    detail_address   VARCHAR(255)                                   NOT NULL COMMENT '상세주소',
    postnumber       VARCHAR(255)                                   NULL COMMENT '우편번호',
    email            VARCHAR(255) unique                            NOT NULL COMMENT '이메일',
    insta_url        VARCHAR(255)                                   NULL COMMENT '인스타url',
    face_url         VARCHAR(255)                                   NULL COMMENT '페이스북url',
    youtube_url      VARCHAR(255)                                   NULL COMMENT '유튜브url',
    profile_img      VARCHAR(255)                                   NULL COMMENT '프로필사진',
    introduce        VARCHAR(255)                                   NULL COMMENT '자기소개',
    email_check_code VARCHAR(8)                                     NULL COMMENT '가입인증이메일코드',
    chapbanner       VARCHAR(255)                                   NULL COMMENT '챱스토리배너',
    u_rstatus        ENUM ('공개', '심사', '비공개', '휴면', '탈퇴', '이메일인증중') NOT NULL COMMENT '상태'
);


CREATE TABLE menu_manages
(
    menu_num  INT primary key auto_increment NOT NULL COMMENT '메뉴번호',
    name      VARCHAR(255)                   NOT NULL COMMENT '메뉴이름',
    img       VARCHAR(255)                   NULL COMMENT '메뉴사진',
    price     INT                            NOT NULL COMMENT '메뉴가격',
    info      VARCHAR(255)                   NULL COMMENT '메뉴설명',
    menu_type ENUM ('대표메뉴', '신메뉴', '일반메뉴')   NOT NULL COMMENT '메뉴종류',
    status    BOOLEAN                        NOT NULL COMMENT '메뉴상태',
    store_num INT                            NOT NULL COMMENT '가게고유번호',
    FOREIGN KEY (store_num) REFERENCES stores (store_num)
);

CREATE TABLE reviews
(
    review_num INT(10) primary key auto_increment NOT NULL COMMENT '리뷰 고유번호',
    content    TEXT                               NULL COMMENT '리뷰 작성내용',
    comment    VARCHAR(255)                       NULL COMMENT '한줄평',
    img        VARCHAR(255)                       NULL COMMENT '가게 메뉴사진',
    date       DATE                               NOT NULL COMMENT '날짜',
    star       INT                                NOT NULL COMMENT '별점1~5',
    r_rstatus  enum ('공개', '심사', '비공개')           NOT NULL COMMENT '신고상태',
    user_id    VARCHAR(255)                       NOT NULL COMMENT '유저아이디',
    store_num  INT                                NOT NULL COMMENT '가게 고유번호',
    menu_num   INT                                NOT NULL COMMENT '메뉴번호',
    FOREIGN KEY (store_num) REFERENCES stores (store_num),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (menu_num) REFERENCES menu_manages (menu_num)
);

CREATE TABLE chapstorys
(
    chap_num    INT auto_increment primary key NOT NULL COMMENT '챱스토리번호',
    title       VARCHAR(255)                   NOT NULL COMMENT '제목',
    content     TEXT                           NOT NULL COMMENT '내용',
    viewcount   INT UNSIGNED                   NULL     DEFAULT 0 COMMENT '조회수',
    post_time   TIMESTAMP                      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성날짜',
    update_time TIMESTAMP                      NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정날짜',
    user_id     VARCHAR(255)                   NOT NULL COMMENT '유저아이디',
    chs_rstatus ENUM ('공개', '심사', '비공개')       NOT NULL DEFAULT '공개' COMMENT '신고상태',
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);
CREATE TABLE chapstoryLikes
(
    likeno   INT auto_increment NOT NULL PRIMARY KEY COMMENT '좋아요고유번호',
    chap_num INT                NOT NULL COMMENT '챱스토리번호',
    user_id  VARCHAR(255)       NOT NULL COMMENT '유저아이디',
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (chap_num) REFERENCES chapstorys (chap_num)
);


CREATE TABLE grades
(
    user_grade VARCHAR(255) NOT NULL COMMENT '유저등급',
    grade_low  INT          NOT NULL COMMENT 'low범위',
    grade_high INT          NOT NULL COMMENT 'high범위'
);

CREATE TABLE visited_store_lists
(
    visited_store_order INT          NOT NULL COMMENT '다녀온 가게 번호',
    visited_date        DATE         NOT NULL COMMENT '다녀온 날짜(웨이팅한 날짜)',
    user_id             VARCHAR(255) NOT NULL COMMENT '유저아이디',
    store_name          VARCHAR(255) NOT NULL COMMENT '가게 이름',
    address             VARCHAR(255) NOT NULL COMMENT '가게 주소'
);

CREATE TABLE recommend_stores
(
    recommend_store_num INT primary key auto_increment NOT NULL COMMENT '추천가게고유번호',
    comment             VARCHAR(255)                   NULL COMMENT '한줄평',
    user_id             VARCHAR(255)                   NOT NULL COMMENT '유저아이디',
    store_num           INT(10)                        NOT NULL COMMENT '가게고유번호',
    FOREIGN KEY (store_num) REFERENCES stores (store_num),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    UNIQUE (user_id, store_num) # 같은가게 추천 두번 못하게
);

CREATE TABLE jjim_manages
(
    jjim_num  int primary key auto_increment NOT NULL COMMENT '즐겨찾기 번호',
    jj_status ENUM ('공개', '비공개')             NOT NULL COMMENT '공개여부',
    user_id   VARCHAR(255)                   NOT NULL COMMENT '유저아이디',
    store_num INT(10)                        NOT NULL COMMENT '가게고유번호',
    FOREIGN KEY (store_num) REFERENCES stores (store_num),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    UNIQUE (user_id, store_num) # 같은가게 찜 두번 못하게
);

CREATE TABLE reviewlikes
(
    rl_id      INT primary key auto_increment NOT NULL COMMENT '좋아요 아이디',
    rl_status  ENUM ('LIKE', 'BAD')           NOT NULL COMMENT '좋아요 싫어요',
    user_id    VARCHAR(255)                   NOT NULL COMMENT '유저 아이디',
    review_num INT(10)                        NOT NULL COMMENT '리뷰 고유번호',
    FOREIGN KEY (review_num) REFERENCES reviews (review_num),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE userswaiting
(
    waiting_num  INT primary key auto_increment    NOT NULL COMMENT '웨이팅 고유번호',
    user_people  INT                               NOT NULL COMMENT '유저 인원수',
    waiting_date DATE                              NOT NULL COMMENT '웨이팅 날짜',
    start_time   VARCHAR(255)                      NOT NULL COMMENT '웨이팅 등록시간',
    end_time     VARCHAR(255)                      NULL COMMENT '웨이팅 입장시간',
    enter_status ENUM ('대기', '완료', '유저취소', '사장취소') NOT NULL COMMENT '입장완료상태체크',
    user_id      VARCHAR(255)                      NOT NULL COMMENT '유저아이디',
    store_num    INT                               NOT NULL COMMENT '가게고유번호',
    FOREIGN KEY (store_num) REFERENCES stores (store_num),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    unique (waiting_date,user_id,store_num)
);

CREATE TABLE storeswaiting
(
    admin_waiting INT primary key NOT NULL COMMENT '웨이팅 테이블',
    closing_time  VARCHAR(255)    NOT NULL COMMENT '웨이팅 마감시간',
    max_people    INT             NOT NULL COMMENT '웨이팅 최대 인원수',
    waiting_onoff BOOLEAN         NOT NULL COMMENT '웨이팅 on/off',
    time_setup    INT             NOT NULL COMMENT '웨이팅 시간 설정',
    store_ads     VARCHAR(255)    NULL COMMENT '가게홍보 url',
    store_num     INT             NOT NULL COMMENT '가게 고유번호',
    FOREIGN KEY (store_num) REFERENCES stores (store_num)
);

CREATE TABLE type_classes
(
    category_num  INT primary key        NOT NULL COMMENT '업종카테고리',
    main_category ENUM ('음식점','카페','술집') NOT NULL COMMENT '대분류',
    sub_category  VARCHAR(255)           NOT NULL COMMENT '소분류'
);

CREATE TABLE storetypes
(
    storetype_id INT primary key auto_increment NOT NULL COMMENT '업종id',
    store_num    INT                            NOT NULL COMMENT '가게고유번호',
    category_num INT                            NOT NULL COMMENT '업종카테고리',
    FOREIGN KEY (store_num) REFERENCES stores (store_num),
    FOREIGN KEY (category_num) REFERENCES type_classes (category_num)
);

CREATE TABLE breaktimes
(
    rest_num        INT primary key auto_increment NOT NULL COMMENT '휴식시간',
    rest_start_time TIME                           NULL COMMENT '휴식시작시간',
    rest_end_time   TIME                           NULL COMMENT '휴식 끝시간',
    store_num       INT                            NOT NULL COMMENT '가게고유번호',
    FOREIGN KEY (store_num) REFERENCES stores (store_num)
);

CREATE TABLE holidays
(
    holi_num  int unsigned primary key auto_increment NOT NULL COMMENT '휴일번호',
    store_num INT                                     NOT NULL COMMENT '가게고유번호',
    week      ENUM ('월','화','수','목','금','토','일')      NULL COMMENT '요일',
    date      DATE                                    NULL COMMENT '일',
    regular   BOOLEAN                                 NULL COMMENT '정규/비정규',
    FOREIGN KEY (store_num) REFERENCES stores (store_num)
);

CREATE TABLE chap_deals
(
    event_num       INT primary key auto_increment NOT NULL COMMENT '이벤트보드번호',
    store_num       INT                            NULL COMMENT '가게고유번호',
    event_title     VARCHAR(255)                   NULL COMMENT '이벤트 제목',
    event_condition VARCHAR(255)                   NULL COMMENT '이벤트 조건',
    event_reward    VARCHAR(255)                   NULL COMMENT '이벤트 보상',
    event_img       VARCHAR(255)                   NULL COMMENT '이벤트 이미지',
    event_start     DATE                           NULL COMMENT '이벤트 시작기간',
    event_end       DATE                           NULL COMMENT '이벤트 끝나는기간',
    FOREIGN KEY (store_num) REFERENCES stores (store_num)
);

CREATE TABLE points
(
    point_num    INT primary key auto_increment NOT NULL COMMENT '포인트 고유번호',
    point_date   DATE                           NULL COMMENT '포인트 적립날짜',
    point_plus   INT                            NULL COMMENT '적립포인트',
    point_reason VARCHAR(255)                   NULL COMMENT '포인트 받은 이유',
    user_id      VARCHAR(255)                   NOT NULL COMMENT '유저아이디',
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE chapstoryimgs
(
    chs_num  INT primary key auto_increment NOT NULL COMMENT '챱사진 고유번호',
    chap_num INT                            NOT NULL COMMENT '챱스토리 번호',
    img      VARCHAR(255)                   NOT NULL COMMENT '이미지 경로(path)',
    FOREIGN KEY (chap_num) REFERENCES chapstorys (chap_num)
);

CREATE TABLE review_replies
(
    rr_num     INT primary key auto_increment NOT NULL COMMENT '리뷰에 사장님의 대댓글',
    review_num INT(10)                        NOT NULL COMMENT '리뷰 고유번호',
    post_date  date                           NOT NULL COMMENT '작성 날짜',
    content    VARCHAR(255)                   NOT NULL COMMENT '작성 내용',
    FOREIGN KEY (review_num) REFERENCES reviews (review_num)
);

CREATE TABLE store_imgs
(
    img_num   INT primary key auto_increment NOT NULL COMMENT '이미지 고유번호',
    store_num INT                            NOT NULL COMMENT '가게고유번호',
    store_img VARCHAR(255)                   NULL COMMENT '가게사진',
    FOREIGN KEY (store_num) REFERENCES stores (store_num)
);

CREATE TABLE reports
(
    report_num      int auto_increment primary key NOT NULL COMMENT '신고번호',
    report_store_id VARCHAR(255)                   NULL COMMENT '신고한 사장님 아이디',
    report_user_id  VARCHAR(255)                   NULL COMMENT '신고한 유저 아이디',
    report_content  VARCHAR(255)                   NULL COMMENT '신고내용',
    review_num      INT(10)                        NULL COMMENT '리뷰 고유번호',
    user_id         VARCHAR(255)                   NULL COMMENT '신고당한 유저 아이디',
    chap_num        INT                            NULL COMMENT '챱스토리 번호',
    store_num       INT                            NULL COMMENT '가게 고유번호',
    FOREIGN KEY (review_num) REFERENCES reviews (review_num),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (chap_num) REFERENCES chapstorys (chap_num),
    FOREIGN KEY (store_num) REFERENCES stores (store_num)
    # report_store_id 와 report_user_id 둘중 하나는 NULL 이어야 함
    # review_num 와 user_id 와 chap_num 와 store_num 의 4개중 3개는 NULL 이어야 함
);

CREATE TABLE chat_rooms
(
    cr_id       INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '채팅방 아이디',
    user_id     VARCHAR(255) NOT NULL COMMENT '채팅방 생성자 아이디',
    name        VARCHAR(255) NOT NULL COMMENT '채팅방 이름',
    description TEXT COMMENT '채팅방 설명',
    post_time   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '채팅방 생성 시간',
    profile_img VARCHAR(255) NULL COMMENT '프로필사진',
    update_time TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '채팅방 최근 업데이트 시간',
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE chat_messages
(
    cm_id     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY COMMENT '메시지 아이디',
    cr_id     INT UNSIGNED                  NOT NULL COMMENT '채팅방 아이디',
    user_id   VARCHAR(255)                  NOT NULL COMMENT '송신자 아이디',
#     nickname  VARCHAR(255)                  NOT NULL COMMENT '송신자 닉네임',
    content   TEXT                          NOT NULL COMMENT '메시지 내용',
    status    ENUM ('ENTER','LEAVE','CHAT') NOT NULL COMMENT '메세지 상태 상태',
    post_time TIMESTAMP                     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '메시지 전송 시간',
    FOREIGN KEY (cr_id) REFERENCES chat_rooms (cr_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (user_id) ON DELETE CASCADE ON UPDATE CASCADE
#     FOREIGN KEY (user_id, nickname) REFERENCES users (user_id, nickname) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE follow
(
    follow_id   int auto_increment primary key      NOT NULL COMMENT '팔로우 데이터 고유속성번호',
    from_id     VARCHAR(255)                        NOT NULL COMMENT '나를 팔로우하고 있음',
    to_id       VARCHAR(255)                        NOT NULL COMMENT '내가 팔로우하고 있음',
#     follow_time timestamp default current_timestamp NOT NULL COMMENT '없어도 됨',
    unique (from_id, to_id) comment '목록 중복 지정 차단 속성',
    foreign key (from_id) references users (user_id) on update cascade on delete cascade,
    foreign key (to_id) references users (user_id) on update cascade on delete cascade
);

#여기부터 더미데이터 / store_manages 는 1000개 더미데이터 따로있음
INSERT INTO store_manages (store_id, pw, business_num, store_call, phone, email) VALUES
                                                                                     ('store001', 'pw123456', '1234567890', '02-1234-5678', '010-1111-2222', 'store001_owner@email.com'),
                                                                                     ('store002', 'pw234567', '2345678901', '02-2345-6789', '010-2222-3333', 'store002_owner@email.com'),
                                                                                     ('store003', 'pw345678', '3456789012', '02-3456-7890', '010-3333-4444', 'store003_owner@email.com'),
                                                                                     ('store004', 'pw456789', '4567890123', '02-4567-8901', '010-4444-5555', 'store004_owner@email.com'),
                                                                                     ('store005', 'pw567890', '5678901234', '02-5678-9012', '010-5555-6666', 'store005_owner@email.com'),
                                                                                     ('store006', 'pw678901', '6789012345', '02-6789-0123', '010-6666-7777', 'store006_owner@email.com'),
                                                                                     ('store007', 'pw789012', '7890123456', '02-7890-1234', '010-7777-8888', 'store007_owner@email.com'),
                                                                                     ('store008', 'pw890123', '8901234567', '02-8901-2345', '010-8888-9999', 'store008_owner@email.com'),
                                                                                     ('store009', 'pw901234', '9012345678', '02-9012-3456', '010-9999-0000', 'store009_owner@email.com'),
                                                                                     ('store010', 'pw012345', '0123456789', '02-0123-4567', '010-0000-1111', 'store010_owner@email.com'),
                                                                                     ('admin', '1234', '9012345678', '02-9012-3456', '010-9999-0000', 'admin_owner@email.com');
# stores도 1000개 더미데이터 따로있음
INSERT INTO stores (store_num, store_name, detail_info, short_info, madein, address, main_img, opentime, lastorder, waiting_closetime, blogurl, youtubeurl, facebookurl, instaurl, s_rstatus, parking, wifi, toilet, smokingroom, babychair) VALUES
                                                                                                                                                                                                                                                 (1, '맛있는 햄버거집', '다양한 햄버거와 사이드 메뉴를 즐길 수 있는 가게입니다.', '햄버거 천국', '미국', '서울시 은평구 은평로 85', 'logo.png', '10:00 - 22:00', '21:30', '21:00', 'http://burger-blog.com', NULL, 'http://facebook.com/burger', 'http://instagram.com/burger', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (2, '닭갈비 전문점', '신선한 닭고기와 야채로 만든 맛있는 닭갈비를 즐길 수 있는 곳입니다.', '닭갈비의 정석', '한국', '경기도 부천시 작동로 28', 'logo.png', '11:00 - 23:00', '22:30', '22:00', 'http://dakgalbi-blog.com', NULL, 'http://facebook.com/dakgalbi', 'http://instagram.com/dakgalbi', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (3, '탕수육명가', '존맛탱 탕수육을 즐길 수 있는 중국요리 전문점입니다.', '탕수육의 정석', '중국', '서울시 은평구 은평로 210', 'logo.png', '10:00 - 22:00', '21:30', '21:00', 'http://tangsuyuk-blog.com', NULL, 'http://facebook.com/tangsuyuk', 'http://instagram.com/tangsuyuk', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (4, '쌀국수 파라다이스', '베트남 전통 쌀국수를 맛볼 수 있는 가게입니다.', '쌀국수 천국', '베트남', '서울시 마포구 양화로 111', 'logo.png', '10:00 - 22:00', '21:30', '21:00', 'http://pho-blog.com', NULL, 'http://facebook.com/pho', 'http://instagram.com/pho', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (5, '빵 맛집', '다양한 종류의 빵을 판매하는 베이커리입니다.', '빵의 세계', '한국', '서울시 마포구 토정로 193', 'logo.png', '09:00 - 21:00', '20:30', '20:00', 'http://bread-blog.com', NULL, 'http://facebook.com/bread', 'http://instagram.com/bread', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (6, '초밥 천국', '신선한 회로 만든 초밥을 즐길 수 있는 일본요리 전문점입니다.', '초밥의 정석', '일본', '서울시 용산구 대사관로 59', 'logo.png', '11:00 - 23:00', '22:30', '22:00', 'http://sushi-blog.com', NULL, 'http://facebook.com/sushi', 'http://instagram.com/sushi', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (7, '족발 맛집', '부드러운 족발을 판매하는 한식 전문점입니다.', '족발의 세계', '한국', '서울시 서초구 남부순환로 2137', 'logo.png', '16:00 - 02:00', '01:30', '01:00', 'http://jokbal-blog.com', NULL, 'http://facebook.com/jokbal', 'http://instagram.com/jokbal', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (8, '치킨 프라자', '맛있는 치킨을 판매하는 프라이드치킨 전문점입니다.', '치킨의 정석', '한국', '충청북도 진천군 초평면 칠성배길 18', 'logo.png', '16:00 - 02:00', '01:30', '01:00', 'http://chicken-blog.com', NULL, 'http://facebook.com/chicken', 'http://instagram.com/chicken', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (9, '돈까스 천국', '바삭바삭한 돈까스를 판매하는 일본요리 전문점입니다.', '돈까스의 정석', '일본', '광주광역시 서구 시청로96번길 12', 'logo.png', '11:00 - 22:00', '21:30', '21:00', 'http://donkatsu-blog.com', NULL, 'http://facebook.com/donkatsu', 'http://instagram.com/donkatsu', '공개', TRUE, TRUE, TRUE, FALSE, TRUE),
                                                                                                                                                                                                                                                 (10, '파스타 레스토랑', '다양한 종류의 파스타를 판매하는 이탈리아 요리 전문점입니다.', '파스타 천국', '이탈리아', '전라남도 순천시 왕지로 30', 'logo.png', '11:00 - 23:00', '22:30', '22:00', 'http://pasta-blog.com', NULL, 'http://facebook.com/pasta', 'http://instagram.com/pasta', '공개', TRUE, TRUE, TRUE, FALSE, TRUE);


INSERT INTO users (user_id, nickname, pw, name, birth, gender, address, detail_address, email, insta_url, face_url, youtube_url, profile_img, introduce, u_rstatus)VALUES
                                                                                                                                                                       ('admin', '관리자', '1234', '관리자', '1999-11-12', 'MALE', '서울특별시 마포구', '에이콘아카데미', 'admin@example.com', NULL, NULL, NULL, NULL, '관리자', '공개'),
                                                                                                                                                                       ('user01', '철수', 'password123', '김철수', '1990-01-01', 'MALE', '서울시 강남구 역삼동', '아파트 101호', 'chulsoo@example.com', 'https://www.instagram.com/chulsoo', NULL, NULL, NULL, '안녕하세요, 김철수입니다.', '공개'),
                                                                                                                                                                       ('user02', '영희', 'password123', '박영희', '1995-05-05', 'FEMALE', '서울시 서초구 반포동', '빌라 201호', 'younghee@example.com', NULL, 'https://www.facebook.com/younghee', NULL, NULL, '안녕하세요, 박영희입니다.', '심사'),
                                                                                                                                                                       ('user03', '수민', 'password123', '이수민', '1985-10-10', 'MALE', '경기도 부천시 원미구', '오피스텔 302호', 'soomin@example.com', NULL, NULL, 'https://www.youtube.com/soomin', NULL, '안녕하세요, 이수민입니다.', '비공개'),
                                                                                                                                                                       ('user04', '민지', 'password123', '김민지', '2000-03-03', 'FEMALE', '인천광역시 부평구', '아파트 501호', 'minji@example.com', 'https://www.instagram.com/minji', NULL, NULL, NULL, '안녕하세요, 김민지입니다.', '공개'),
                                                                                                                                                                       ('user05', '준호', 'password123', '박준호', '1992-12-12', 'MALE', '대구광역시 중구', '오피스텔 201호', 'junho@example.com', NULL, 'https://www.facebook.com/junho', NULL, NULL, '안녕하세요, 박준호입니다.', '공개'),
                                                                                                                                                                       ('user06', '보검', 'password123', '박보검', '1993-06-16', 'MALE', '서울특별시 강남구', '언주로 12길 29', 'test01@gmail.com', 'https://www.instagram.com/pbg', NULL, NULL, 'https://image.com/pbg.jpg', '안녕하세요, 박보검입니다.', '공개'),
                                                                                                                                                                       ('user07', '예진', 'password123', '손예진', '1982-01-11', 'FEMALE', '서울특별시 강서구', '등촌로 123', 'test02@gmail.com', 'https://www.instagram.com/yejinhand', NULL, NULL, 'https://image.com/yejin.jpg', '안녕하세요, 손예진입니다.', '공개'),
                                                                                                                                                                       ('user08', '종석', 'password123', '이종석', '1987-08-04', 'MALE', '경기도 수원시 영통구', '대학로 123', 'test03@gmail.com', 'https://www.instagram.com/jongsuk0206', NULL, NULL, 'https://image.com/jongsuk.jpg', '안녕하세요, 이종석입니다.', '공개'),
                                                                                                                                                                       ('user09', '효주', 'password123', '한효주', '1987-02-22', 'FEMALE', '서울특별시 종로구', '돈화문로 21길 12', 'test04@gmail.com', 'https://www.instagram.com/hyozzang', NULL, NULL, 'https://image.com/hyozzang.jpg', '안녕하세요, 한효주입니다.', '공개'),
                                                                                                                                                                       ('user10', '남준', 'password5678', '김남준', '1994-09-12', 'MALE', '서울특별시 용산구', '이태원로 3길 30', 'test05@gmail.com', 'https://www.instagram.com/bts.bighitofficial', NULL, 'https://www.youtube.com/channel/UC3IZKseVpdzPSBaWxBxundA', 'https://image.com/bts.jpg', '안녕하세요, 김남준입니다.', '공개'),
                                                                                                                                                                       ('user11', '민수', 'password123', '이민수', '1989-03-22', 'MALE', '부산광역시 동래구', '아파트 301호', 'minsuyy@example.com', 'https://www.instagram.com/minsuyy', NULL, NULL, NULL, '안녕하세요, 이민수입니다.', '공개'),
                                                                                                                                                                       ('user12', '유나', 'password123', '김유나', '1998-08-08', 'FEMALE', '인천광역시 계양구', '빌라 102호', 'yuna_kim@example.com', NULL, 'https://www.facebook.com/yuna_kim', NULL, NULL, '안녕하세요, 김유나입니다.', '심사'),
                                                                                                                                                                       ('user13', '성민', 'password123', '김성민', '1987-07-07', 'MALE', '대전광역시 유성구', '아파트 701호', 'smkim@example.com', NULL, NULL, 'https://www.youtube.com/smkim', NULL, '안녕하세요, 김성민입니다.', '비공개'),
                                                                                                                                                                       ('user14', '영호', 'password123', '이영호', '2001-01-01', 'MALE', '서울특별시 강서구', '오피스텔 201호', 'young_ho@example.com', 'https://www.instagram.com/young_ho', NULL, NULL, NULL, '안녕하세요, 이영호입니다.', '공개'),
                                                                                                                                                                       ('user15', '진아', 'password123', '박진아', '1994-04-15', 'FEMALE', '경기도 안양시', '빌라 501호', 'jinapark@example.com', NULL, 'https://www.facebook.com/jinapark', NULL, NULL, '안녕하세요, 박진아입니다.', '공개'),
                                                                                                                                                                       ('user16', '서준', 'password123', '김서준', '1996-06-16', 'MALE', '경기도 하남시', '오피스텔 501호', 'seojun@example.com', 'https://www.instagram.com/seojun', NULL, NULL, NULL, '안녕하세요, 김서준입니다.', '공개'),
                                                                                                                                                                       ('user17', '민영', 'password123', '이민영', '1988-12-25', 'FEMALE', '서울특별시 마포구', '아파트 102호', 'minyoung@example.com', NULL, 'https://www.facebook.com/minyoung', NULL, NULL, '안녕하세요, 이민영입니다.', '공개'),
                                                                                                                                                                       ('user18', '준기', 'password123', '김준기', '1999-09-09', 'MALE', '서울특별시 송파구', '아파트 302호', 'junki@example.com', 'https://www.instagram.com/junki', NULL, NULL, NULL, '안녕하세요, 김준기입니다.', '공개'),
                                                                                                                                                                       ('user19', '진수', 'password123', '박진수', '1993-07-01', 'MALE', '서울특별시 동작구', '오피스텔 201호', 'jinsu@example.com', NULL, 'https://www.facebook.com/jinsu', NULL, NULL, '안녕하세요, 박진수입니다.', '공개'),
                                                                                                                                                                       ('user20', '은지', 'password123', '김은지', '1995-11-20', 'FEMALE', '인천광역시 서구', '아파트 601호', 'eunji_kim@example.com', NULL, NULL, 'https://www.youtube.com/eunji_kim', NULL, '안녕하세요, 김은지입니다.', '심사');

INSERT INTO chapstorys (title, content, viewcount, post_time, update_time, user_id, chs_rstatus)
VALUES ('어나더클럽 방문기!!', '제가 연남동에 있는 어나더 클럽에 방문하여 치즈후라이피자를 먹어보았습니다. 이제 그 경험을 바탕으로 블로그 리뷰 글을 작성해보겠습니다.

우선, 어나더 클럽은 매우 분위기 있는 곳이었습니다. 조명과 음악이 잘 어우러져 있어서, 친구들과 함께 시간을 보내기 좋은 곳이라는 느낌을 받았습니다.

주문한 치즈후라이피자는 정말 맛있었습니다. 피자 반죽은 바삭하고 쫀득하면서도 적당한 두께감이 있었고, 치즈와 후라이드 포테이토의 조화가 뛰어나 매우 풍부한 맛을 느낄 수 있었습니다. 또한, 치즈와 후라이드 포테이토를 함께 먹을 수 있는 특별한 경험을 제공해준 것 같습니다.

그 외에도 어나더 클럽''에서는 다양한 피자 메뉴와 사이드 메뉴, 음료 등을 제공하고 있습니다. 그중에서도 피자는 정말 맛있었고, 특히 치즈후라이피자는 제가 먹어본 피자 중에서도 최고였습니다.

다만, 가격은 다른 피자집에 비해서 조금 높다는 느낌을 받았습니다. 그러나, 그만큼 품질과 맛이 보장되는 것 같아서 가격에 비해 합리적인 가격정책이라는 느낌도 받았습니다.

종합적으로, 어나더 클럽''에서 제공하는 치즈후라이피자는 정말 맛있고, 분위기 또한 좋은 곳이었습니다. 가격이 다소 높을 수 있지만, 그만큼 맛과 품질이 보장되는 것 같아서 꼭 한 번쯤 방문해보길 추천드립니다.', 300, '2023-03-11 00:00:00', '2023-03-11 00:00:00', 'user01', '공개'),

       ('보쌈 맛집 추천해드려용', '제가 방문한 보쌈집은 서울시 강남구에 위치한 보관이라는 곳이었습니다. 이곳에서는 전통적인 보쌈 요리뿐만 아니라, 보쌈을 포함한 다양한 돼지고기 요리를 제공하고 있습니다.

우선, 보관의 보쌈은 정말 맛있었습니다. 살코기와 껍질 모두 부드럽고, 간도 딱 적당해서 밥과 함께 먹으면 최고의 맛을 느낄 수 있었습니다. 또한, 보쌈과 함께 제공되는 김치와 쌈채소도 신선하고 맛있어서, 완성도 높은 한 끼 식사를 즐길 수 있었습니다.

또한, 보관에서는 보쌈 이외에도 다양한 돼지고기 요리를 제공합니다. 그중에서도 돼지껍데기와 돼지갈비찜은 제가 먹어본 것 중에서도 가장 맛있었습니다. 특히 돼지갈비찜은 고기가 뼈에 따라 붙어있어서, 부드러운 고기와 고소한 소스가 더해져 꼭 한 번 먹어봐야 할 맛입니다.

또한, 보관은 인테리어와 분위기도 좋아서, 가족들이나 친구들과 함께 즐기기 좋은 곳입니다. 다만, 가격이 조금 비싸다는 느낌을 받았습니다. 그러나, 그만큼 품질과 맛이 보장되는 것 같아서 가격에 비해 합리적인 가격정책이라는 느낌도 받았습니다.

종합적으로, 보관에서는 보쌈을 비롯한 다양한 돼지고기 요리를 제공하고 있으며, 맛과 품질 모두 높은 곳입니다. 인테리어와 분위기도 좋아서, 가족들이나 친구들과 함께 즐기기 좋은 곳입니다. 가격은 다소 비싸지만, 그만큼 맛과 품질이 보장되는 것 같아서 꼭 한 번쯤 방문해보길 추천드립니다. ', 290, '2023-03-12 00:00:00', '2023-03-12 14:00:00', 'user02', '공개'),

       ('전통적인 냉면', '저는 서울 중구에 위치한 평가옥이라는 곳에서 냉면을 맛보았습니다. 이곳은 전통적인 손맛으로 만든 냉면을 제공하는 곳으로, 인기 맛집 중 하나로 손꼽히고 있습니다.

제가 주문한 냉면은 평가옥의 대표 메뉴인 메밀소바였습니다. 먼저, 면은 부드럽고 탱글탱글해서 입안에서 살살 녹아내리는 것이 느껴졌습니다. 냉면국물은 깊은 맛이 나서 적당한 물기와 함께 적절한 농도를 느낄 수 있었습니다. 또한, 김치와 쪽파, 머위 등의 색다른 재료와 함께 먹으면 더욱 맛이 좋아지는 것 같았습니다.

그 외에도 평가옥에서는 전통적인 물냉면과 비빔냉면, 육수 냉면 등 다양한 냉면을 제공합니다. 그 중에서도 제가 먹어본 메밀소바는 정말 맛있었습니다.

다만, 평가옥은 인기 맛집이기 때문에 대기 시간이 조금 길다는 느낌을 받았습니다. 하지만, 그만큼 맛있는 냉면을 먹을 수 있는 것이니 조금의 대기 시간은 감수할 만합니다.

종합적으로, 평가옥에서는 전통적인 손맛으로 만든 냉면을 즐길 수 있으며, 메밀소바는 정말 맛있는 대표 메뉴입니다. 대기 시간이 조금 길 수 있지만, 그만큼 맛있는 냉면을 먹을 수 있는 것이니 꼭 한 번쯤 방문해보길 추천드립니다.', 250, '2023-03-12 00:00:00', '2023-03-12 14:00:00', 'user02', '공개'),

       ('신선한 맛과 부드러운 튀김옷', '서울 종로구에 위치한 마이산 돈까스를 방문하여, 이곳에서 제공하는 돈까스를 맛보았습니다.

돈까스는 돈육의 신선한 맛과 부드러운 튀김 옷으로 유명한 이곳에서 정말 맛있게 먹을 수 있었습니다. 입안에서 녹는 돈육과 튀김 옷이 입맛을 돋우는 맛이었습니다. 또한, 소스와 함께 먹으면 더욱 맛을 느낄 수 있었습니다.

마이산 돈까스에서는 다양한 종류의 돈까스를 제공하고 있는데, 그중에서도 양념 돈까스와 치즈 돈까스는 매우 맛있었습니다. 특히 양념 돈까스는 매콤한 양념과 함께 먹으면 깔끔하면서도 강렬한 맛이 나서 중독성이 있었습니다.

다만, 가격이 다른 돈까스집에 비해 조금 높다는 느낌을 받았습니다. 그러나, 그만큼 맛과 품질이 보장되는 것 같아서 가격에 비해 합리적인 가격정책이라는 느낌도 받았습니다.

종합적으로, 마이산 돈까스에서는 신선한 돈육과 부드러운 튀김 옷으로 만든 돈까스를 제공하고 있으며, 양념 돈까스와 치즈 돈까스도 매우 맛있습니다. 가격은 다소 높을 수 있지만, 그만큼 맛과 품질이 보장되는 것 같아서 꼭 한 번쯤 방문해보길 추천드립니다.', 240, '2023-03-13 00:00:00', '2023-03-13 00:00:00', 'user03', '공개'),
       ('자연밥상김밥', '서울시 성북구에 위치한 자연밥상 김밥은 맛있는 김밥으로 유명한 식당입니다. 제가 시식한 메뉴는 참치마요 김밥과 돈까스 김밥입니다.

먼저, 참치마요 김밥은 참치와 계란 등의 신선한 재료를 넣어서 맛을 더한 김밥입니다. 밥의 식감과 간이 정확해서 입안에서 녹는 것 같았습니다. 참치와 계란 등의 재료도 신선하게 준비되어 있어서, 건강하면서도 맛있게 먹을 수 있었습니다.

그리고 돈까스 김밥은 돈까스와 채소 등이 들어간 김밥으로, 특히 돈까스의 풍미와 부드러움이 돋보이는 메뉴였습니다. 김밥 속에 들어있는 돈까스가 크기가 적당해서 한 입에 먹을 수 있었고, 맛 또한 정말 좋았습니다.

또한, 자연밥상 김밥에서는 김밥뿐만 아니라 다양한 메뉴를 제공합니다. 특히 더운 여름에는 물냉면이 인기 있는 메뉴 중 하나입니다.

가격도 다른 김밥집에 비해 저렴하며, 청결한 식당 내부와 친절한 서비스로 인상적이었습니다.

종합적으로, 자연밥상 김밥에서는 신선한 재료와 정확한 간으로 맛있는 김밥을 제공합니다. 가격도 저렴하며, 청결한 식당 내부와 친절한 서비스로 인상적이었습니다. 김밥을 좋아하시는 분들께 강력히 추천드리는 김밥집입니다.', 230, '2023-03-14 00:00:00', '2023-03-14 00:00:00', 'user01', '공개'),
       ('납작만두 냠냠냠너무맛있어', '제가 이번에 먹어본 음식은 납작만두입니다! 서울 중구에 위치한 납작만두공장은 유명한 길거리 납작만두 전문점 중 하나입니다. 납작만두는 일반적인 만두보다 조금 더 얇고 크기도 작아서 한 입에 쏙 들어가기 쉽습니다.

납작만두는 기본적으로 고기만두, 김치만두, 소고기만두, 새우만두 등 다양한 종류가 있으며, 다양한 사이드 메뉴와 함께 즐길 수 있습니다. 저는 고기만두와 새우만두를 시식해봤는데, 둘 다 매우 맛있었습니다. 특히 새우만두는 신선한 새우와 담백한 고기가 어우러져서, 입맛을 돋우는 맛이었습니다.

납작만두의 가격은 다른 길거리 음식점에 비해서는 조금 높은 편입니다. 그러나, 퀄리티와 맛은 충분히 보장되는 것 같아서 가격 대비 만족도는 높다고 생각합니다.

종합적으로, 납작만두공장에서는 다양한 종류의 납작만두를 제공하고 있으며, 특히 고기만두와 새우만두는 정말 맛있습니다. 가격은 조금 높은 편이지만, 맛과 퀄리티는 충분히 보장되어 있어서 만족스러운 길거리 음식점 중 하나입니다.', 220, '2023-03-15 00:00:00', '2023-03-15 00:00:00', 'user04', '공개'),
       ('매콤하고 쫄깃한 떡볶이를 먹어볼까요', '제가 방문한 떡볶이 전문점은 오봉네 떡볶이입니다.

오봉네 떡볶이는 서울시 마포구에 위치한 떡볶이 전문점으로, 고소한 떡볶이 양념과 쫄깃한 떡이 매력적입니다. 이곳에서 시식한 메뉴는 오봉네 떡볶이와 오봉네 떡강정입니다.

오봉네 떡볶이는 달콤하면서도 매콤한 맛이 일품입니다. 특히 떡이 쫄깃하게 끓여져서 맛이 더욱 높아졌습니다. 추가로 떡볶이와 같이 드시는 오뎅과 순대도 부드럽고 맛있어서 살짝 더 담백한 맛을 느낄 수 있었습니다.

오봉네 떡강정은 바삭하면서도 달콤한 맛으로, 떡강정에 묻어있는 카라멜 소스의 풍미가 더해져서 매우 맛있게 먹을 수 있었습니다.

가격은 다른 떡볶이집에 비해서는 조금 높은 편이지만, 맛과 양, 서비스 등이 높아서 가격에 비해 만족스러웠습니다.

종합적으로, 오봉네 떡볶이에서는 매콤하고 쫄깃한 떡볶이와 바삭하면서도 달콤한 떡강정을 제공합니다. 가격은 다소 높은 편이지만, 맛과 양, 서비스 등이 높아서 가격에 비해 만족스러웠습니다. 떡볶이를 좋아하시는 분들께 강력히 추천드리는 떡볶이 전문점입니다.', 210, '2023-03-16 00:00:00', '2023-03-16 00:00:00', 'user04', '공개'),
       ('삼겹살 맛있게 굽는법 알려드림', '삼겹살을 맛있게 굽는 방법에 대해 알려드릴게요!

1.삼겹살 사전 처리하기
삼겹살은 냉장고에서 꺼내어 냄새가 나지 않도록 청소해줍니다. 냄새가 심한 부분은 칼로 가볍게 긁어내면서 깨끗하게 해줍니다. 그리고 적당한 크기로 자른 후에, 반드시 냉장고에서 냉장보관해야 합니다.

2.적당한 불로 굽기
삼겹살은 기름이 많아서 불이 강하면 불이 붙을 위험이 있습니다. 따라서 불을 중간 정도로 조절하여 노릇하게 굽습니다. 불을 너무 강하게 조절하면 삼겹살이 구울 때 불순물이 많이 생기고, 불을 너무 약하게 조절하면 고기가 부드럽게 구워지지 않을 수 있으니 적당한 불로 조절하는 것이 중요합니다.

3.숯불보다 가스불이 더 좋습니다.
삼겹살을 구울 때는 숯불보다 가스불이 더 좋습니다. 가스불은 온도를 조절하기 쉬우며, 냄새와 불순물이 적어서 고기의 풍미가 더욱 빛납니다.

4.특별한 소스를 사용해보세요.
삼겹살을 맛있게 굽기 위해서는 특별한 소스를 사용해보세요. 간장, 고추장, 마늘, 고추 등을 섞어서 만든 간장 양념, 고추장 양념, 마늘 간장 등 다양한 소스를 사용하여 맛을 더할 수 있습니다.

5.적절한 익힘으로 맛을 더해보세요.
삼겹살은 적당한 익힘에서 맛이 더욱 빛납니다. 완전히 익혀서 불순물을 제거해도 괜찮지만, 너무 익혀버리면 삼겹살의 맛이 떨어질 수 있으니 적절한 익힘으로 맛을 더해보세요.

6.잘게 자른 후 먹기
삼겹살을 구울 때는 잘게 자른 후 먹는 것이 맛을 더욱 높여줍니다. 덜 구운 고기라면 그대부분의 경우, 삼겹살은 더 부드러워서 맛있어지기 때문에 잘게 자른 후 먹는 것이 좋습니다. 또한 삼겹살은 식사의 대표적인 반찬 중 하나이기 때문에, 다양한 나물과 함께 먹으면 더욱 맛있게 즐길 수 있습니다.

                                                 마지막으로, 삼겹살을 맛있게 굽는 방법을 알아봤는데요. 더욱 맛있게 즐길 수 있는 비법 중 하나는, 고기를 굽기 전에 먹고자 하는 인원 수에 맞게 적당한 양을 준비하는 것입니다. 적당한 양의 고기를 구워서 먹으면, 고기의 맛을 더욱 즐길 수 있고 낭비도 방지할 수 있습니다.', 200, '2023-03-17 00:00:00', '2023-03-17 00:00:00', 'user05', '공개'),
       ('역시 낙지보단 쭈꾸미지', '제가 방문한 직화 쭈꾸미집을 리뷰해드릴게요.

서울 중구에 위치한 쭈꾸미집은 직화로 구운 쭈꾸미를 맛볼 수 있는 인기 맛집입니다. 이곳에서 가장 추천하는 메뉴는 직화 쭈꾸미입니다.

직화 쭈꾸미는 신선한 쭈꾸미를 기름 없이 직화로 구워내어 맛이 더욱 진하고 고소한 향이 나는 요리입니다. 또한, 쭈꾸미가 넉넉하게 들어있어서 한번에 많이 먹을 수 있어 만족도가 높았습니다. 또한, 다양한 새콤달콤한 양념과 함께 즐길 수 있어서, 맛에 대한 선택 폭이 높은 것도 장점 중 하나입니다.

가격은 다른 쭈꾸미집에 비해 조금 높은 편이지만, 퀄리티와 맛은 충분히 보장되는 것 같아서 가격 대비 만족도는 높다고 생각합니다.

종합적으로, 쭈꾸미집에서는 직화로 구운 쭈꾸미를 맛볼 수 있으며, 맛있는 새콤달콤한 양념과 함께 즐길 수 있습니다. 가격은 다소 높은 편이지만, 맛과 퀄리티는 충분히 보장되어 있어서 만족스러운 직화 쭈꾸미집 중 하나입니다.', 190, '2023-03-18 00:00:00', '2023-03-19 14:00:00', 'user06', '공개'),
       ('통막걸리와 매운막걸리찜닭', '저는 서울시 마포구에 위치한 서광식당에서 시식한 경험이 있습니다.

서광식당은 전통적인 한국의 술인 막걸리와 함께 맛있는 안주를 즐길 수 있는 곳입니다. 이곳에서 가장 추천하는 메뉴는 통 막걸리와 매운막걸리찜닭입니다.

통 막걸리는 무형광을 사용하지 않고, 오래된 방식으로 양조한 술이며, 향과 맛이 더욱 진하고 깔끔합니다. 술의 질이 매우 높아서 한 잔 먹는 즉시 입 안에서 퍼지는 맛과 향이 인상적입니다. 매운막걸리찜닭은 술 안주로 최적인 찜닭 메뉴입니다. 찜닭의 양념과 막걸리의 맛이 상쾌하면서도 깊은 맛을 느낄 수 있습니다. 또한, 찜닭 안에 들어있는 감자, 당면, 고구마 등 다양한 식재료가 입안에서 쫄깃하게 느껴져서 맛을 더욱 즐길 수 있습니다.

가격은 다른 술집에 비해서는 조금 높은 편이지만, 맛과 퀄리티는 충분히 보장되는 것 같아서 가격 대비 만족도는 높다고 생각합니다.

종합적으로, 서광식당에서는 전통적인 통 막걸리와 함께 맛있는 안주를 즐길 수 있으며, 특히 통 막걸리와 매운막걸리찜닭은 정말 맛있습니다. 가격은 다소 높은 편이지만, 맛과 퀄리티는 충분히 보장되어 있어서 만족스러운 막걸리집 중 하나입니다.', 160, '2023-03-19 00:00:00', '2023-03-20 14:00:00', 'user07', '공개'),
       ('치즈가 폭포로 흐르는 라볶이', '저는 서울시 송파구에 위치한 치즈폭포라볶이에서 시식한 경험이 있습니다.

치즈폭포라볶이는 쫄깃한 떡과 짭쪼름한 매콤한 소스, 그리고 풍부한 치즈가 듬뿍 얹어져 있는 메뉴로 유명합니다. 이곳에서 가장 추천하는 메뉴는 치즈폭포라볶이입니다.

치즈폭포라볶이는 떡이 쫄깃하게 살아있으며, 소스의 매운맛과 치즈의 풍미가 잘 어울려서 맛있게 즐길 수 있습니다. 또한, 분위기 있는 가게 내부와 친절한 서비스도 인상적입니다.

가격은 다른 떡볶이집에 비해 조금 높은 편이지만, 맛과 양이 더해진다는 점에서 가격 대비 만족도가 높다고 생각합니다. 또한, 매장 내부 분위기와 친절한 서비스도 만족스러웠습니다.

종합적으로, 치즈폭포라볶이에서는 쫄깃하고 매콤한 떡볶이와 치즈의 조화가 일품입니다. 가격은 다소 높은 편이지만, 맛과 양, 서비스 모두 높은 수준이기 때문에 만족스러운 떡볶이집 중 하나입니다.', 140, '2023-03-20 00:00:00', '2023-03-21 14:00:00', 'user08', '공개'),
       ('감자탕 맛집 추천', '서울시 종로구에 위치한 동원집은 매일 300명 이상의 손님들이 찾는 감자탕집으로 유명합니다. 이곳에서 가장 추천하는 메뉴는 동원 감자탕입니다.

동원 감자탕은 분명한 국물맛과 함께 부드러운 고기와 감자가 푹 끓어서 맛이 깊고 진한 감칠맛이 일품입니다. 이 감자탕은 40년 이상의 역사를 가지고 있으며, 천연조미료와 순한양념으로 만들어지기 때문에 불필요한 조미료가 들어가지 않아 건강에도 좋습니다.

가격은 다른 감자탕집에 비해서는 조금 높은 편이지만, 맛과 양이 더해진다는 점에서 가격 대비 만족도가 높다고 생각합니다. 또한, 서비스도 좋아서 손님들의 만족도도 높은 편입니다.

종합적으로, 동원집에서는 깊은 맛과 함께 건강에도 좋은 동원 감자탕을 맛볼 수 있습니다. 가격은 다소 높은 편이지만, 맛과 양, 서비스 모두 높은 수준이기 때문에 만족스러운 감자탕집 중 하나입니다.', 29, '2023-03-21 00:00:00', '2023-03-22 14:00:00', 'user09', '공개'),
       ('바질페스토 쉽고 간단하게 만드는 법 알려드림', '바질페스토는 이탈리안 요리에서 매우 중요한 재료 중 하나입니다. 신선한 바질, 마늘, 파마산 치즈, 오일 등을 이용하여 매우 쉽게 만들 수 있습니다.

바질페스토를 만드는 방법은 다음과 같습니다.

재료:

1. 신선한 바질 2컵
2. 마늘 2개
3. 파마산 치즈 1/2컵
4. 캐슈넛(혹은 다른 견과류) 1/3컵
5. 올리브 오일 1컵
6. 소금, 후추



만드는 방법:

1. 바질을 깨끗이 씻어 물기를 제거합니다.
2. 마늘은 껍질을 벗기고 잘게 다지거나 갈아주세요.
3. 파마산 치즈와 캐슈넛을 블렌더에 넣고 섞어주세요.
4. 바질과 마늘을 더해 블렌더를 이용하여 갈아주세요.
5. 갈아낸 바질과 마늘, 파마산 치즈, 캐슈넛을 모두 섞어주면서 올리브 오일을 천천히 붓고 섞어주세요.
6. 소금과 후추로 간을 해주고, 더 갈아낼 때까지 블렌더를 돌려주세요.

이렇게 만든 바질페스토는 파스타와 함께 즐기는 것이 일반적이지만, 빵이나 샐러드 등 다양한 음식과 함께 즐길 수도 있습니다. 만들어 둔 바질페스토는 냉장고에 보관하여 오랫동안 사용할 수 있습니다.', 80, '2023-03-22 00:00:00', '2023-04-22 14:00:00', 'user10', '공개'),
       ('꼬치구이 맛집', '소이자카야에서는 일본 전통 음식인 이자카야를 즐길 수 있습니다. 이자카야는 일본의 소주나 맥주를 마시면서 간단한 안주를 즐기는 문화이며, 여기서 가장 추천하는 안주는 꼬치구이입니다.

꼬치구이는 다양한 종류의 꼬치를 즐길 수 있는데, 닭고기, 소고기, 돼지고기, 새우, 오징어 등을 선택할 수 있습니다. 꼬치는 쫄깃하면서도 부드러우며, 소스도 직접 만든 것으로 더욱 맛있습니다.

이곳에서는 다양한 안주와 함께 일본 맥주나 소주를 즐길 수 있습니다. 또한, 분위기 있는 내부 인테리어와 친절한 서비스도 인상적입니다.

가격은 이자카야의 특성상 다른 음식점보다는 다소 높은 편입니다. 하지만, 맛과 분위기, 서비스까지 고려하면 가격 대비 만족도가 높다고 생각합니다.

종합적으로, 소이자카야에서는 맛있는 꼬치구이와 함께 분위기 있는 이자카야 문화를 즐길 수 있습니다. 가격은 다소 높은 편이지만, 맛과 분위기, 서비스 모두 높은 수준이기 때문에 만족스러운 이자카야 중 하나입니다.', 90, '2023-04-23 00:00:00', '2023-04-23 14:00:00', 'user11', '공개'),
       ('꼬치에꽂혀~~', ' 저는 서울시 강남구에 위치한 양꼬치 형제에서 시식한 경험이 있습니다.

양꼬치 형제는 대형 목장에서 직접 공급받은 신선한 양고기를 사용하여 만든 양꼬치로 유명합니다. 이곳에서 가장 추천하는 메뉴는 양꼬치입니다.

양꼬치 형제에서 제공하는 양꼬치는 양고기만을 사용하여 만들어져, 부드럽고 쫄깃한 식감이 일품입니다. 또한, 직접 만든 매운 양념과 양고기의 고소한 맛이 어우러져 정말 맛있게 즐길 수 있습니다.

가격은 다른 양꼬치집에 비해서는 조금 높은 편이지만, 양꼬치의 크기가 크고 양고기의 질이 좋아서 가격 대비 만족도가 높다고 생각합니다. 또한, 깔끔한 내부 인테리어와 친절한 서비스도 인상적입니다.

종합적으로, 양꼬치 형제에서는 신선하고 맛있는 양고기로 만든 양꼬치를 즐길 수 있습니다. 가격은 다소 높은 편이지만, 양고기의 질과 크기, 매운 양념 등 고객들의 만족도를 높인 요소들이 많기 때문에 추천할 만한 양꼬치집 중 하나입니다.', 58, '2023-04-24 00:00:00', '2023-04-24 14:00:00', 'user12', '공개'),
       ('고소한 휘낭시에 드셔보세요~~', '이번에는 휘낭시에 맛집에 다녀왔습니다 !!
휘낭시에가는 프랑스어로 소란스러운 거리라는 뜻으로, 굉장히 예쁘고 아기자기한 분위기의 카페입니다. 이곳에서는 다양한 커피와 디저트를 즐길 수 있습니다. 가장 추천하는 메뉴는 유자치즈케이크와 아이스 아메리카노입니다.

유자치즈케이크는 부드러운 치즈와 유자의 상큼한 맛이 어우러져 정말 맛있게 즐길 수 있습니다. 또한, 카페에서 직접 로스팅한 커피의 향긋한 향과 함께 즐길 수 있는 아이스 아메리카노도 추천합니다.

가격은 다른 카페에 비해서는 조금 높은 편입니다. 하지만, 분위기 있는 내부 인테리어와 친절한 서비스, 그리고 맛과 퀄리티가 높은 디저트와 커피로 인해 가격 대비 만족도가 높다고 생각합니다.

종합적으로, 휘낭시에가에서는 예쁘고 아기자기한 분위기 속에서 맛과 퀄리티가 높은 디저트와 커피를 즐길 수 있습니다. 가격은 다소 높은 편이지만, 분위기와 서비스, 맛과 퀄리티 등을 모두 고려하면 만족스러운 카페 중 하나입니다.', 36, '2023-04-25 00:00:00', '2023-04-25 14:00:00', 'user13', '공개'),
       ('김선생이 다녀온 맛집 저도 다녀옴', ' 김선생이 리뷰한 맛집 중 하나는 대전 유성구에 위치한 대청호반점입니다. 김선생이 추천한 메뉴는 자장면과 탕수육입니다.

대청호반점의 자장면은 짭짤한 맛과 함께 고소한 느낌이 일품입니다. 또한, 탱글탱글한 면발과 함께 쫄깃한 고기조각이 어우러져 맛과 식감이 정말 좋습니다.

탕수육은 바삭한 튀김옷과 함께 부드러운 돼지고기가 일품입니다. 또한, 직접 만든 달콤한 소스와 함께 즐기면 맛이 더욱 더해집니다.

가격은 다른 중국집에 비해서는 다소 높은 편입니다. 하지만, 맛과 양, 퀄리티 등 모두 높아서 가격 대비 만족도가 높다고 생각합니다. 또한, 깔끔한 내부 인테리어와 친절한 서비스도 인상적입니다.

종합적으로, 대청호반점에서는 짭짤한 맛이 일품인 자장면과 바삭하고 부드러운 탕수육을 즐길 수 있습니다. 가격은 다소 높은 편이지만, 맛과 양, 퀄리티 등을 모두 고려하면 만족스러운 중국집 중 하나입니다.', 52, '2023-04-25 00:00:00', '2023-04-26 14:00:00', 'user14', '공개'),
       ('맥딜리버리 얄려드립니다!', '맥딜리버리는 맥도날드에서 운영하는 배달 앱으로, 다양한 음식점에서 주문 가능한 서비스를 제공합니다.

가장 큰 장점은 바로 다양한 음식점과 메뉴를 한 곳에서 쉽게 주문할 수 있다는 것입니다. 또한, 앱 내에서 쉽게 결제할 수 있어서 편리합니다.

하지만, 주문 건이 많아지면 배달이 지연되는 경우가 있어서 이 점은 고려해야 할 부분입니다. 또한, 가끔 주문한 메뉴와 다른 메뉴가 배달되는 경우도 있어서 조심해야 합니다.

또한, 맥딜리버리를 이용하면 할인 쿠폰을 받을 수 있어서 가격적으로도 매우 유리합니다.

종합적으로, 맥딜리버리는 다양한 음식점과 메뉴를 한 곳에서 쉽게 주문할 수 있는 편리한 배달 앱입니다. 다만, 주문 건이 많아지면 배달이 지연되는 경우가 있으니 이 점을 고려하고 이용하시는 것이 좋습니다. 또한, 할인 쿠폰을 적극 활용하여 가격적으로도 매우 유리하게 이용할 수 있습니다.', 64, '2023-04-26 00:00:00', '2023-04-26 14:00:00', 'user15', '공개'),
       ('엄마의 손맛... 리뷰입니다', '맘스터치는 대한민국의 패스트푸드 브랜드 중 하나로, 다양한 메뉴와 맛있는 햄버거로 유명합니다.

가장 추천하는 메뉴는 싸이버거와 치즈스틱입니다. 싸이버거는 고소한 식빵과 함께 쫄깃한 패티와 상큼한 야채, 그리고 특별한 소스가 어우러져 정말 맛있게 즐길 수 있습니다. 치즈스틱은 바삭하게 튀겨진 외피와 부드러운 치즈가 조화를 이루며, 입 안에서 살짝 녹아내리는 맛이 일품입니다.

또한, 맘스터치는 식자재를 공급하는 자체 공장을 보유하고 있어서, 신선하고 청결한 식재료로 만들어진 메뉴를 즐길 수 있습니다.

가격은 다른 패스트푸드 브랜드에 비해서는 다소 높은 편입니다. 하지만, 맛과 퀄리티, 건강에 대한 고려 등을 모두 고려하면 가격 대비 만족도가 높다고 생각합니다.

종합적으로, 맘스터치는 다양한 메뉴와 맛있는 햄버거로 유명한 대한민국의 패스트푸드 브랜드입니다. 특히, 싸이버거와 치즈스틱은 꼭 한 번 시도해봐야 할 메뉴 중 하나입니다. 맛과 퀄리티, 건강에 대한 고려 등을 모두 고려하면 가격 대비 만족도가 높은 패스트푸드 브랜드 중 하나입니다.', 12, '2023-04-26 00:00:00', '2023-04-27 14:00:00', 'user16', '공개'),
       ('청정묵사발 너무 맛있어요', '제가 추천하는 묵사발 맛집은 경기도 안양시에 위치한 청정묵사발입니다.

청정묵사발의 묵사발은 깊고 진한 육수와 함께 쫄깃하고 부드러운 묵을 먹는 즐거움을 선사합니다. 특히, 묵은 제철 식재료를 사용하여 맛과 건강을 모두 고려한 요리입니다.

또한, 청정묵사발은 묵사발 외에도 다양한 메뉴를 제공합니다. 대표적인 메뉴로는 해물파전, 순대, 묵순떡볶이 등이 있으며, 모두 신선한 재료와 정성스런 요리로 제공됩니다.

가격은 다른 음식점에 비해서는 조금 높은 편입니다. 하지만, 맛과 건강을 고려한 신선한 재료와 정성스러운 요리, 푸짐한 양 등을 모두 고려하면 가격 대비 만족도가 높다고 생각합니다.

종합적으로, 청정묵사발은 깊고 진한 육수와 함께 쫄깃하고 부드러운 묵을 즐길 수 있는 묵사발 맛집입니다. 묵사발 외에도 다양한 메뉴를 제공하며, 신선한 재료와 정성스러운 요리로 제공됩니다. 가격은 조금 높은 편이지만, 맛과 건강, 푸짐한 양 등을 모두 고려하면 가격 대비 만족도가 높은 음식점 중 하나입니다.', 75, '2023-04-27 00:00:00', '2023-04-27 14:00:00', 'user17', '공개'),
       ('등촌칼국수 죤맛탱 ㅠㅠ', ' 등촌칼국수는 서울 강서구에 위치한 칼국수 전문점으로, 30년 이상의 역사와 전통을 자랑합니다.

등촌칼국수의 칼국수는 국물이 매우 진하고 깊은 맛을 가지고 있으며, 면발 또한 쫄깃하고 탱탱합니다. 또한, 메밀가루와 밀가루를 함께 사용하여 만들어져서, 색다른 맛과 향이 일품입니다.

특히, 등촌칼국수에서는 손질된 닭고기를 사용하여 국물의 맛과 풍미를 한층 더 높여줍니다. 또한, 계절마다 달라지는 육수의 재료와 양념의 양식도 매우 고민해서 제공하고 있습니다.

가격은 다른 칼국수집에 비해서는 조금 높은 편입니다. 하지만, 깊은 맛과 탱탱한 면발, 손질된 닭고기 등의 신선한 재료와 정성스러운 요리, 그리고 깔끔한 내부 인테리어와 친절한 서비스까지 모두 고려하면 가격 대비 만족도가 높다고 생각합니다.

종합적으로, 등촌칼국수는 깊은 맛과 탱탱한 면발, 손질된 닭고기 등의 신선한 재료와 정성스러운 요리, 그리고 깔끔한 내부 인테리어와 친절한 서비스까지 모두 고려하면 가격 대비 만족도가 높은 칼국수 전문점 중 하나입니다. 맛있는 칼국수를 먹고 싶다면 등촌칼국수를 꼭 추천드립니다.', 37, '2023-04-30 00:00:00', '2023-04-30 14:00:00', 'user18', '공개'),
       ('전통 오코노미야끼 먹어보았습니다!', '마루야의 오코노미야끼는 촉촉하고 부드러운 밀가루로 만들어진 외피와 함께 신선한 새우, 조개, 돼지고기 등 다양한 재료를 함께 구워낸 것이 특징입니다. 또한, 소스의 맛 또한 진하고 깊은 맛을 자랑하며, 여러 가지 토핑을 추가할 수 있어서 맛을 더욱 높여줍니다.

또한, 마루야는 오코노미야끼 뿐만 아니라, 도톰한 국수 면과 고소한 찹쌀떡 등 다양한 메뉴도 제공하고 있습니다.

가격은 다른 일식집에 비해서는 다소 비싼 편입니다. 하지만, 신선한 재료와 정성스러운 요리, 그리고 깔끔한 내부 인테리어와 친절한 서비스까지 모두 고려하면 가격 대비 만족도가 높다고 생각합니다.

종합적으로, 마루야는 촉촉하고 부드러운 외피와 신선한 재료로 만들어진 오코노미야끼를 즐길 수 있는 일식집입니다. 여러 가지 토핑을 추가할 수 있어서 맛을 더욱 높일 수 있으며, 다양한 메뉴도 제공합니다. 가격은 다소 비싼 편이지만, 맛과 퀄리티, 서비스까지 모두 고려하면 가격 대비 만족도가 높은 오코노미야끼 맛집 중 하나입니다.', 53, '2023-04-30 00:00:00', '2023-04-30 14:00:00', 'user19', '공개'),
       ('이태원 라멘스타 다녀왔습니당', '제가 추천하는 라멘집은 서울 용산구 이태원동에 위치한 라멘스타입니다.

라멘스타의 라멘은 깊고 진한 육수와 탱탱한 면발이 매력적입니다. 특히, 다양한 종류의 라멘을 제공하며, 육수의 특징과 면발의 식감이 다른 라멘들보다 더욱 두드러지게 느껴집니다. 또한, 육수의 고소한 맛과 함께 신선한 재료와 정성스러운 요리로 제공됩니다.

또한, 라멘스타는 라멘 외에도 다양한 일본식 음식을 제공합니다. 대표적인 메뉴로는 돈부리, 규동, 소바 등이 있으며, 모두 신선한 재료와 정성스런 요리로 제공됩니다.

가격은 다른 라멘집에 비해서는 조금 높은 편입니다. 하지만, 깊은 맛과 탱탱한 면발, 신선한 재료와 정성스러운 요리, 그리고 깔끔한 내부 인테리어와 친절한 서비스까지 모두 고려하면 가격 대비 만족도가 높다고 생각합니다.

종합적으로, 라멘스타는 깊은 맛과 탱탱한 면발, 신선한 재료와 정성스러운 요리, 그리고 깔끔한 내부 인테리어와 친절한 서비스까지 모두 고려하면 가격 대비 만족도가 높은 라멘집입니다. 다양한 종류의 라멘과 다양한 일본식 음식을 즐길 수 있으며, 맛있는 라멘을 먹고 싶다면 라멘스타를 꼭 추천드립니다.', 27, '2023-04-30 00:00:00', '2023-04-30 14:00:00', 'user01', '공개'),
       ('맛있는 전통 멕시코 타코', 'Gringos는 멕시코 전통의 타코를 제공하는 레스토랑으로, 신선한 재료와 향신료를 사용하여 매우 정교하게 만들어진 타코를 즐길 수 있습니다. 특히, 고기와 야채, 그리고 치즈와 소스 등을 조합하여 다양한 맛을 느낄 수 있도록 다양한 종류의 타코를 제공합니다.

타코의 외피도 멕시코 전통 방식을 따라서 손으로 눌러서 만들어져서, 쫄깃하고 탱탱한 식감이 매우 인상적입니다. 또한, 신선한 재료와 정교하게 조합된 소스는 강렬한 맛과 향을 자랑합니다.

가격은 다른 타코집에 비해서는 조금 높은 편입니다. 하지만, 신선한 재료와 정성스러운 요리, 그리고 깔끔한 내부 인테리어와 친절한 서비스까지 모두 고려하면 가격 대비 만족도가 높다고 생각합니다.

종합적으로, Gringos는 멕시코 전통의 타코를 제공하는 레스토랑으로, 신선한 재료와 향신료를 사용하여 매우 정교하게 만들어진 타코를 즐길 수 있습니다. 타코의 외피도 쫄깃하고 탱탱하며, 다양한 종류의 타코와 소스를 즐길 수 있습니다. 가격은 다른 타코집에 비해서는 조금 높은 편이지만, 맛과 퀄리티, 서비스까지 모두 고려하면 가격 대비 만족도가 높은 타코집 중 하나입니다.', 74, '2023-04-30 00:00:00', '2023-04-30 14:00:00', 'user01', '공개');


INSERT INTO type_classes (category_num,main_category, sub_category)
VALUES
    (1,'음식점', '혼밥'),
    (2,'음식점', '족발'),
    (3,'음식점', '보쌈'),
    (4,'음식점', '치킨'),
    (5,'음식점', '고기'),
    (6,'음식점', '양식'),
    (7,'음식점', '백반'),
    (8,'음식점', '일식'),
    (9,'음식점', '회'),
    (10,'음식점', '중식'),
    (11,'음식점', '아시안'),
    (12,'음식점', '패스트푸드'),
    (13,'음식점', '찜'),
    (14,'음식점', '해물'),
    (15,'음식점', '돈까스'),
    (16,'음식점', '탕,찌개'),
    (17,'음식점', '국수'),
    (18,'음식점', '분식'),
    (19,'음식점', '기타'),
    (20,'술집', '호프집'),
    (21,'술집', '바'),
    (22,'술집', '이자카야'),
    (23,'술집', '포차'),
    (24,'술집', '와인바'),
    (25,'술집', '기타'),
    (26,'카페', '커피전문점'),
    (27,'카페', '디저트카페'),
    (28,'카페', '차전문점'),
    (29,'카페', '베이커리카페'),
    (30,'카페', '기타');

INSERT INTO menu_manages (name, img, price, info, menu_type, status, store_num) VALUES
                                                                                    ('불고기햄버거', '/images/menu/img-1682943517352.jpg', 7000, '맛있는 햄버거', '대표메뉴', true, 1),
                                                                                    ('치즈버거', '/images/menu/img-1682943525934.jpg', 8000, '치즈가 듬뿍 들어간 햄버거', '일반메뉴', true, 1),
                                                                                    ('감자튀김', '/images/menu/img-1682943537244.jpg', 5000, '바삭한 감자튀김', '일반메뉴', true, 1),
                                                                                    ('매운닭갈비', '/images/menu/img-1682944063953.jpg', 15000, '매콤한 닭갈비', '대표메뉴', true, 2),
                                                                                    ('치즈닭갈비', '/images/menu/img-1682944070342.jpg', 17000, '치즈를 뿌린 닭갈비', '일반메뉴', true, 2),
                                                                                    ('불고기', '/images/menu/img-1682944077411.jpg', 15000, '맛있는 불고기', '일반메뉴', true, 2),
                                                                                    ('찹쌀탕수육', 'https://example.com/tangsuyuk.jpg', 12000, '바삭한 탕수육', '대표메뉴', true, 3),
                                                                                    ('잡채', '/images/menu/img-1682944138148.jpg', 10000, '고기와 채소가 들어간 잡채', '일반메뉴', true, 3),
                                                                                    ('울면', '/images/menu/img-1682944158604.jpg', 9000, '매콤한 울면', '일반메뉴', true, 3),
                                                                                    ('베트남쌀국수', '/images/menu/img-1682944210933.jpg', 8000, '시원한 쌀국수', '대표메뉴', true, 4),
                                                                                    ('불고기쌀국수', '/images/menu/img-1682944779501.jpg', 10000, '불고기와 쌀국수의 환상조합', '일반메뉴', true, 4),
                                                                                    ('야채쌀국수', '/images/menu/img-1682944788744.jpg', 8000, '시원한 야채쌀국수', '일반메뉴', true, 4),
                                                                                    ('바게트', '/images/menu/img-1682944851440.jpg', 3000, '부드러운 빵', '대표메뉴', true, 5),
                                                                                    ('크로와상', '/images/menu/img-1682944897982.jpg', 3500, '버터향 가득한 크로와상', '일반메뉴', true, 5),
                                                                                    ('마카롱', '/images/menu/img-1682944905958.jpg', 2000, '색다른 마카롱', '일반메뉴', true, 5),
                                                                                    ('초밥', '/images/menu/img-1682945019850.jpg', 20000, '신선한 초밥', '대표메뉴', true, 6),
                                                                                    ('족발', '/images/menu/img-1682945082541.jpg', 18000, '맛있는 족발', '대표메뉴', true, 7),
                                                                                    ('치킨', '/images/menu/img-1682945136728.jpg', 16000, '바삭한 치킨', '대표메뉴', true, 8),
                                                                                    ('돈까스', '/images/menu/img-1682945196593.jpg', 9000, '고소한 돈까스', '대표메뉴', true, 9),
                                                                                    ('파스타', '/images/menu/img-1682945235379.jpg', 13000, '크리미한 파스타', '대표메뉴', true, 10);


INSERT INTO storetypes (store_num, category_num)
VALUES
    (1, 7),
    (2, 8),
    (3, 5),
    (4, 6),
    (5, 20),
    (6, 2),
    (7, 1),
    (8, 7),
    (9, 2),
    (10, 4);

INSERT INTO reviews (content, comment, img, date, star, r_rstatus, user_id, store_num, menu_num) VALUES
                                                                                                     ('맛있는 치킨이었습니다. 분위기도 좋았어요.', '맛있는 치킨', 'chicken1.jpg', '2023-04-01', 5, '공개', 'user01', 1, 1),
                                                                                                     ('피자가 아주 맛있었습니다. 다음에 또 올게요!', '최고의 피자', 'pizza1.jpg', '2023-04-02', 3, '공개', 'user02', 2, 4),
                                                                                                     ('초밥이 신선하고 맛있었습니다. 서비스도 좋았습니다.', '신선한 초밥', 'sushi1.jpg', '2023-04-03', 2, '공개', 'user03', 3, 7),
                                                                                                     ('김밥이 너무 맛있어요! 가격도 저렴해서 좋았습니다.', '저렴한 김밥', 'kimbap1.jpg', '2023-04-04', 4, '공개', 'user04', 4, 10),
                                                                                                     ('떡볶이가 매콤하고 맛있었습니다. 포장해서 먹었어요.', '떡볶이 추천', 'tteokbokki1.jpg', '2023-04-05', 5, '공개', 'user05', 5, 13),
                                                                                                     ('삼겹살이 아주 부드럽고 맛있었습니다. 배부르게 먹었어요.', '부드러운 삼겹살', 'samgyeopsal1.jpg', '2023-04-06', 2, '공개', 'user06', 6, 16),
                                                                                                     ('파스타가 존맛탱이었습니다. 소스도 좋았어요.', '맛있는 파스타', 'pasta1.jpg', '2023-04-07', 3, '공개', 'user07', 7, 17),
                                                                                                     ('커피가 진짜 맛있었어요. 디저트도 추천합니다.', '커피 맛집', 'coffee1.jpg', '2023-04-08', 1, '공개', 'user08', 8, 18),
                                                                                                     ('라멘이 정말 맛있었습니다. 국물이 진해요.', '라멘 맛집', 'ramen1.jpg', '2023-04-09', 2, '공개', 'user09', 9, 19),
                                                                                                     ('짜장면이 아주 맛있었습니다. 짬뽕도 시켜봤는데 좋았어요.', '중화요리 추천', 'jajangmyeon1.jpg', '2023-04-10', 3, '공개', 'user10', 10, 20),
                                                                                                     ('햄버거가 아주 맛있었습니다. 다양한 메뉴가 있어 좋았어요.', '맛있는 햄버거', 'burger1.jpg', '2023-04-11', 4, '공개', 'user11', 1, 1),
                                                                                                     ('닭갈비가 아주 맛있었습니다. 야채도 신선해요!', '닭갈비 최고', 'dakgalbi1.jpg', '2023-04-12', 5, '공개', 'user12', 2, 4),
                                                                                                     ('탕수육이 존맛탱이었습니다. 짬뽕도 좋았어요.', '중식 맛집', 'tangsuyuk1.jpg', '2023-04-13', 1, '공개', 'user13', 3, 7),
                                                                                                     ('쌀국수가 정말 맛있었습니다. 국물이 진해요.', '쌀국수 맛집', 'pho1.jpg', '2023-04-14', 2, '공개', 'user14', 4, 10),
                                                                                                     ('빵이 너무 맛있어요! 친절한 서비스도 좋았습니다.', '빵 맛집', 'bread1.jpg', '2023-04-15 16:00:00', 3, '공개', 'user15', 5, 13),
                                                                                                     ('돈까스가 아주 부드럽고 맛있었습니다. 소스도 좋았어요.', '돈까스 추천', 'donkatsu1.jpg', '2023-04-16', 4, '공개', 'user16', 6, 16),
                                                                                                     ('샐러드가 정말 신선하고 맛있었습니다. 다양한 메뉴가 있어요.', '샐러드 맛집', 'salad1.jpg', '2023-04-17', 5, '공개', 'user17', 7, 17),
                                                                                                     ('냉면이 아주 맛있었습니다. 여름에 먹기 좋아요!', '냉면 맛집', 'naengmyeon1.jpg', '2023-04-18', 1, '공개', 'user18', 8, 18),
                                                                                                     ('참치회가 신선하고 맛있었습니다. 소주랑 잘 어울려요.', '참치회 추천', 'chamchi1.jpg', '2023-04-19', 2, '공개', 'user19', 9, 19),
                                                                                                     ('케이크가 정말 맛있었습니다. 다양한 종류가 있어 고르기 어려웠어요.', '케이크 맛집', 'cake1.jpg', '2023-04-20', 2, '공개', 'user20', 10, 20),
                                                                                                     ('두부김치가 아주 맛있었습니다. 매운맛이 좋았어요.', '두부김치 맛집', 'dubukimchi1.jpg', '2023-04-21', 3, '공개', 'user11', 1, 1),
                                                                                                     ('감자탕이 정말 맛있었습니다. 국물이 진해요.', '감자탕 추천', 'gamjatang1.jpg', '2023-04-22', 4, '공개', 'user20', 2, 4),
                                                                                                     ('생선회가 신선하고 맛있었습니다. 와사비랑 잘 어울려요.', '생선회 맛집', 'sashimi1.jpg', '2023-04-23', 5, '공개', 'user13', 3, 7),
                                                                                                     ('김치찌개가 아주 맛있었습니다. 배부르게 먹었어요.', '김치찌개 추천', 'kimchijjigae1.jpg', '2023-04-24',1, '공개', 'user14', 4, 10),
                                                                                                     ('해물파전이 정말 맛있었습니다. 소주랑 잘 어울려요.', '해물파전 맛집', 'haemulpajeon1.jpg', '2023-04-25', 2, '공개', 'user15', 5, 13),
                                                                                                     ('갈비탕이 아주 부드럽고 맛있었습니다. 감동이었어요.', '갈비탕 추천', 'galbitang1.jpg', '2023-04-26', 3, '공개', 'user06', 6, 16),
                                                                                                     ('치즈돈까스가 정말 맛있었습니다. 치즈가 풍성해요.', '치즈돈까스 맛집', 'cheesedonkatsu1.jpg', '2023-04-27', 4, '공개', 'user07', 7, 17),
                                                                                                     ('짬뽕이 아주 맛있었습니다. 매콤한맛이 좋았어요!', '짬뽕 추천', 'jjamppong1.jpg', '2023-04-28', 5, '공개', 'user18', 8, 18),
                                                                                                     ('불고기가 정말 맛있었습니다. 소고기가 부드러워요.', '불고기 맛집', 'bulgogi1.jpg', '2023-04-29', 5, '공개', 'user19', 9, 19),
                                                                                                     ('크림파스타가 아주 맛있었습니다. 크림이 부드러워요.', '크림파스타 추천', 'creampasta1.jpg', '2023-04-30', 1, '공개', 'user20', 10, 20),
                                                                                                     ('햄버거가 아주 맛있었습니다. 다음에 또 오고 싶어요.', '햄버거 최고!', 'hamburger1.jpg', '2023-04-01', 2, '공개', 'user13', 7, 17),
                                                                                                     ('닭갈비가 아주 맛있어요. 양념도 좋고 고기도 신선해요.', '닭갈비 맛집', 'dakgalbi2.jpg', '2023-04-02', 3, '공개', 'user05', 2, 4),
                                                                                                     ('탕수육이 바삭바삭하고 소스도 달지 않아서 좋아요.', '최고의 탕수육', 'tangsuyuk3.jpg', '2023-04-03', 4, '공개', 'user20', 1, 1),
                                                                                                     ('쌀국수가 시원하고 맛있어요. 국물이 정말 좋아요.', '쌀국수 맛집', 'pho4.jpg', '2023-04-04', 5, '공개', 'user07', 4, 10),
                                                                                                     ('빵이 정말 부드럽고 맛있어요. 다양한 종류의 빵이 있어요.', '빵의 천국', 'bread5.jpg', '2023-04-05', 1, '공개', 'user12', 5, 13),
                                                                                                     ('초밥이 신선하고 맛있어요. 회도 부드럽고 좋아요.', '초밥 천국', 'sushi6.jpg', '2023-04-06', 2, '공개', 'user19', 6, 16),
                                                                                                     ('족발이 부드럽고 맛있어요. 소스도 좋아요.', '족발의 세계', 'jokbal7.jpg', '2023-04-07', 3, '공개', 'user01', 7, 17),
                                                                                                     ('치킨이 바삭바삭하고 맛있어요. 소스도 좋아요.', '치킨의 정석', 'chicken8.jpg', '2023-04-08', 4, '공개', 'user16', 8, 18),
                                                                                                     ('돈까스가 바삭하고 맛있어요. 소스도 좋아요.', '돈까스의 정석', 'donkatsu9.jpg', '2023-04-09', 5, '공개', 'user02', 9, 19),
                                                                                                     ('파스타가 맛있어요. 다양한 종류의 파스타가 있어요.', '파스타 천국', 'pasta10.jpg', '2023-04-10', 1, '공개', 'user17', 10, 20),
                                                                                                     ('햄버거가 아주 맛있었습니다. 다음에 또 오고 싶어요.', '햄버거 최고!', 'hamburger11.jpg', '2023-04-11', 2, '공개', 'user09', 1, 1),
                                                                                                     ('닭갈비가 아주 맛있어요. 양념도 좋고 고기도 신선해요.', '닭갈비 맛집', 'dakgalbi12.jpg', '2023-04-12',3, '공개', 'user14', 2, 5),
                                                                                                     ('탕수육이 바삭바삭하고 소스도 달지 않아서 좋아요.', '최고의 탕수육', 'tangsuyuk13.jpg', '2023-04-13', 4, '공개', 'user11', 3, 9),
                                                                                                     ('쌀국수가 시원하고 맛있어요. 국물이 정말 좋아요.', '쌀국수 맛집', 'pho14.jpg', '2023-04-14', 5, '공개', 'user18', 4, 11),
                                                                                                     ('빵이 정말 부드럽고 맛있어요. 다양한 종류의 빵이 있어요.', '빵의 천국', 'bread15.jpg', '2023-04-15', 1, '공개', 'user03', 5, 14),
                                                                                                     ('초밥이 신선하고 맛있어요. 회도 부드럽고 좋아요.', '초밥 천국', 'sushi16.jpg', '2023-04-16', 2, '공개', 'user06', 6, 16),
                                                                                                     ('족발이 부드럽고 맛있어요. 소스도 좋아요.', '족발의 세계', 'jokbal17.jpg', '2023-04-17', 3, '공개', 'user08', 7, 17),
                                                                                                     ('치킨이 바삭바삭하고 맛있어요. 소스도 좋아요.', '치킨의 정석', 'chicken18.jpg', '2023-04-18', 4, '공개', 'user15', 8, 18),
                                                                                                     ('돈까스가 바삭하고 맛있어요. 소스도 좋아요.', '돈까스의 정석', 'donkatsu19.jpg', '2023-04-19', 5, '공개', 'user10', 9, 19),
                                                                                                     ('파스타가 맛있어요. 다양한 종류의 파스타가 있어요.', '파스타 천국', 'pasta20.jpg', '2023-04-20', 1, '공개', 'user04', 10, 20),
                                                                                                     ('피자가 얇고 바삭하면서도 맛있어요. 다양한 토핑이 있어요.', '피자 맛집', 'pizza21.jpg', '2023-04-21',2, '공개', 'user05', 1, 1),
                                                                                                     ('라멘이 진하고 맛있어요. 면도 쫄깃하고 좋아요.', '라멘 천국', 'ramen22.jpg', '2023-04-22', 3, '공개', 'user07', 2, 5),
                                                                                                     ('떡볶이가 매콤하고 맛있어요. 고기도 많아서 좋아요.', '떡볶이 맛집', 'tteokbokki23.jpg', '2023-04-23', 4, '공개', 'user12', 3, 8),
                                                                                                     ('갈비가 부드럽고 맛있어요. 소스도 좋아요.', '갈비 천국', 'galbi24.jpg', '2023-04-24', 5, '공개', 'user10', 4, 10),
                                                                                                     ('김밥이 신선하고 맛있어요. 다양한 종류의 김밥이 있어요.', '김밥 맛집', 'kimbap25.jpg', '2023-04-25', 1, '공개', 'user15', 5, 14),
                                                                                                     ('비빔밥이 고소하고 맛있어요. 야채도 신선해요.', '비빔밥의 정석', 'bibimbap26.jpg', '2023-04-26', 2, '공개', 'user03', 6, 16),
                                                                                                     ('된장찌개가 진하고 맛있어요. 밥도 맛있고 좋아요.', '된장찌개 맛집', 'doenjangjjigae27.jpg', '2023-04-27', 3, '공개', 'user08', 7, 17),
                                                                                                     ('갈비탕이 진하고 맛있어요. 고기도 부드럽고 좋아요.', '갈비탕 천국', 'galbitang28.jpg', '2023-04-28', 4, '공개', 'user11', 8, 18),
                                                                                                     ('냉면이 시원하고 맛있어요. 면도 쫄깃하고 좋아요.', '냉면 맛집', 'naengmyeon29.jpg', '2023-04-29', 5, '공개', 'user06', 9, 19),
                                                                                                     ('칼국수가 시원하고 맛있어요. 면도 쫄깃하고 좋아요.', '칼국수 천국', 'kalguksu30.jpg', '2023-04-30', 1, '공개', 'user14', 2, 5),
                                                                                                     ('샐러드가 다양하고 맛있어요. 드레싱도 좋아요.', '샐러드 맛집', 'salad31.jpg', '2023-05-01', 2, '공개', 'user01', 1, 1),
                                                                                                     ('볶음밥이 고소하고 맛있어요. 야채도 신선해요.', '볶음밥의 정석', 'friedrice32.jpg', '2023-05-02', 3, '공개', 'user09', 2, 6),
                                                                                                     ('떡국이 시원하고 맛있어요. 떡도 쫄깃하고 좋아요.', '떡국 맛집', 'tteokguk33.jpg', '2023-05-03', 4, '공개', 'user16', 3, 8),
                                                                                                     ('오므라이스가 부드럽고 맛있어요. 소스도 좋아요.', '오므라이스 천국', 'omurice34.jpg', '2023-05-04', 5, '공개', 'user19', 4, 11),
                                                                                                     ('스테이크가 부드럽고 맛있어요. 소스도 좋아요.', '스테이크의 정석', 'steak35.jpg', '2023-05-05', 1, '공개', 'user05', 5, 14),
                                                                                                     ('샌드위치가 다양하고 맛있어요. 빵도 신선해요.', '샌드위치 맛집', 'sandwich36.jpg', '2023-05-06', 2, '공개', 'user13', 6, 16),
                                                                                                     ('치즈돈까스가 바삭하고 맛있어요. 소스도 좋아요.', '치즈돈까스 천국', 'cheesedonkatsu37.jpg', '2023-05-07', 3, '공개', 'user07', 7, 17),
                                                                                                     ('라떼가 부드럽고 맛있어요. 커피도 좋아요.', '라떼의 정석', 'latte38.jpg', '2023-05-08', 4, '공개', 'user20', 8, 18),
                                                                                                     ('케이크가 부드럽고 맛있어요. 다양한 종류의 케이크가 있어요.', '케이크 맛집', 'cake39.jpg', '2023-05-09', 5, '공개', 'user02', 9, 19),
                                                                                                     ('찹쌀떡이 쫄깃하고 맛있어요. 다양한 종류의 찹쌀떡이 있어요.', '찹쌀떡 천국', 'chapssalddeok40.jpg', '2023-05-10', 1, '공개', 'user04', 10, 20);
INSERT INTO grades (user_grade, grade_low, grade_high)
VALUES
    ('브론즈', 0, 499),
    ('실버', 500, 1499),
    ('골드', 1500, 2999),
    ('플래티넘', 3000, 5999),
    ('다이아', 6000, 9999);

INSERT INTO reports (
    report_store_id, report_user_id, report_content, review_num, user_id, chap_num, store_num
) VALUES
      (NULL, 'user01', '리뷰1에 대한 신고입니다.', 1, NULL, NULL, NULL),
      (NULL, 'user02', '유저 신고1입니다.', NULL, 'user04', NULL, NULL),
      (NULL, 'user03', '챱스토리1에 대한 신고입니다.', NULL, NULL, 1, NULL),
      (NULL, 'user04', '가게1에 대한 신고입니다.', NULL, NULL, NULL, 1),
      ('store001', NULL, '리뷰2에 대한 신고입니다.', 2, NULL, NULL, NULL),
      ('store002', NULL, '유저 신고2입니다.', NULL, 'user05', NULL, NULL),
      ('store003', NULL, '챱스토리2에 대한 신고입니다.', NULL, NULL, 2, NULL),
      ('store004', NULL, '가게2에 대한 신고입니다.', NULL, NULL, NULL, 2),
      (NULL, 'user01', '리뷰1에 대한 신고입니다.', 1, NULL, NULL, NULL),
      (NULL, 'user02', '유저 신고1입니다.', NULL, 'user04', NULL, NULL),
      (NULL, 'user03', '챱스토리1에 대한 신고입니다.', NULL, NULL, 1, NULL),
      (NULL, 'user04', '가게1에 대한 신고입니다.', NULL, NULL, NULL, 1),
      ('store001', NULL, '리뷰2에 대한 신고입니다.', 2, NULL, NULL, NULL),
      ('store002', NULL, '유저 신고2입니다.', NULL, 'user05', NULL, NULL),
      ('store003', NULL, '챱스토리2에 대한 신고입니다.', NULL, NULL, 2, NULL),
      ('store004', NULL, '가게2에 대한 신고입니다.', NULL, NULL, NULL, 2),
      (NULL, 'user01', '리뷰1에 대한 신고입니다.', 1, NULL, NULL, NULL),
      (NULL, 'user02', '유저 신고1입니다.', NULL, 'user04', NULL, NULL),
      (NULL, 'user03', '챱스토리1에 대한 신고입니다.', NULL, NULL, 1, NULL),
      (NULL, 'user04', '가게1에 대한 신고입니다.', NULL, NULL, NULL, 1),
      ('store001', NULL, '리뷰2에 대한 신고입니다.', 2, NULL, NULL, NULL),
      ('store002', NULL, '유저 신고2입니다.', NULL, 'user05', NULL, NULL),
      ('store003', NULL, '챱스토리2에 대한 신고입니다.', NULL, NULL, 2, NULL),
      ('store004', NULL, '가게2에 대한 신고입니다.', NULL, NULL, NULL, 2),
      (NULL, 'user01', '리뷰3에 대한 신고입니다.', 3, NULL, NULL, NULL),
      (NULL, 'user02', '유저6 신고1입니다.', NULL, 'user06', NULL, NULL),
      (NULL, 'user03', '챱스토리3에 대한 신고입니다.', NULL, NULL, 3, NULL),
      (NULL, 'user04', '가게4에 대한 신고입니다.', NULL, NULL, NULL, 4),
      ('store001', NULL, '리뷰4에 대한 신고입니다.', 4, NULL, NULL, NULL),
      ('store002', NULL, '유저7 신고2입니다.', NULL, 'user07', NULL, NULL),
      ('store003', NULL, '챱스토리3에 대한 신고입니다.', NULL, NULL, 3, NULL),
      ('store004', NULL, '가게4에 대한 신고입니다.', NULL, NULL, NULL, 4);

#웨이팅 관련 더미데이터
INSERT INTO storeswaiting VALUES (1, '18:00:00', 50, true, 15, 'https://store1.com', 1);
INSERT INTO storeswaiting VALUES (2, '19:00:00', 40, true, 20, 'https://store2.com', 2);
INSERT INTO storeswaiting VALUES (3, '17:30:00', 60, true, 10, 'https://store3.com', 3);
INSERT INTO storeswaiting VALUES (4, '20:00:00', 30, true, 30, 'https://store4.com', 4);
INSERT INTO storeswaiting VALUES (5, '18:30:00', 45, true, 25, 'https://store5.com', 5);

INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (3, '2023-05-01', '17:30:00', NULL, '대기', 'user01', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (4, '2023-04-21', '18:00:00', NULL, '대기', 'user02', 2);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (5, '2023-04-22', '17:45:00', NULL, '대기', 'user03', 3);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (2, '2023-04-23', '19:30:00', NULL, '대기', 'user04', 4);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (3, '2023-05-01', '18:15:00', NULL, '대기', 'user05', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (4, '2023-05-01', '19:20:00', NULL, '대기', 'user06', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (2, '2023-05-01', '19:15:00', NULL, '대기', 'user07', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (1, '2023-05-01', '19:00:00', NULL, '대기', 'user08', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (3, '2023-05-01', '18:55:00', NULL, '대기', 'user09', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (2, '2023-05-01', '18:50:00', NULL, '대기', 'user10', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (2, '2023-05-01', '18:45:00', NULL, '대기', 'user11', 1);
INSERT INTO userswaiting (user_people, waiting_date, start_time, end_time, enter_status, user_id, store_num) VALUES (3, '2023-05-01', '18:35:00', NULL, '대기', 'user12', 1);

INSERT INTO visited_store_lists VALUES (1, '2023-04-10', 'user01', '맛있는 햄버거집', '서울시 강남구 역삼동 123-45');
INSERT INTO visited_store_lists VALUES (2, '2023-04-11', 'user02', '닭갈비 전문점', '서울시 강남구 역삼동 234-56');
INSERT INTO visited_store_lists VALUES (3, '2023-04-12', 'user03', '탕수육명가', '서울시 강남구 역삼동 345-67');
INSERT INTO visited_store_lists VALUES (4, '2023-04-13', 'user04', '쌀국수 파라다이스', '서울시 강남구 역삼동 456-78');
INSERT INTO visited_store_lists VALUES (5, '2023-04-14', 'user05', '빵 맛집', '서울시 강남구 역삼동 567-89');

INSERT INTO breaktimes (rest_start_time, rest_end_time, store_num) VALUES
                                                                       ('12:30:00', '13:30:00', 1),
                                                                       ('15:00:00', '15:30:00', 1),
                                                                       ('14:00:00', '14:30:00', 2),
                                                                       ('18:00:00', '18:30:00', 2),
                                                                       ('16:00:00', '16:30:00', 3),
                                                                       ('12:00:00', '12:30:00', 4),
                                                                       ('13:30:00', '14:00:00', 4),
                                                                       ('17:00:00', '17:30:00', 5),
                                                                       ('11:30:00', '12:00:00', 5),
                                                                       ('14:30:00', '15:00:00', 6);

INSERT INTO jjim_manages (jj_status, user_id, store_num) VALUES
                                                             ('공개', 'user01', 1),
                                                             ('비공개', 'user01', 2),
                                                             ('공개', 'user02', 3),
                                                             ('공개', 'user02', 4),
                                                             ('비공개', 'user03', 5),
                                                             ('공개', 'user04', 6),
                                                             ('비공개', 'user04', 7),
                                                             ('공개', 'user05', 8),
                                                             ('비공개', 'user05', 9),
                                                             ('공개', 'user06', 10);

INSERT INTO recommend_stores (comment, user_id, store_num) VALUES
                                                               ('훌륭한 햄버거!', 'user01', 1),
                                                               ('맛있는 닭갈비집!', 'user01', 2),
                                                               ('최고의 탕수육!', 'user01', 3),
                                                               ('맛있는 쌀국수!', 'user02', 4),
                                                               ('신선한 초밥!', 'user02', 6),
                                                               ('맛있는 치킨집!', 'user02', 8),
                                                               ('부드러운 빵이 좋아요', 'user03', 5),
                                                               ('맛있는 돈까스집!', 'user03', 9),
                                                               ('커리가 맛있는 파스타집!', 'user03', 10),
                                                               ('족발이 정말 맛있어요!', 'user04', 7);

INSERT INTO reviewlikes (rl_status, user_id, review_num) VALUES
                                                             ('LIKE', 'user01', 1),
                                                             ('LIKE', 'user02', 2),
                                                             ('BAD', 'user03', 3),
                                                             ('LIKE', 'user04', 4),
                                                             ('BAD', 'user05', 5),
                                                             ('LIKE', 'user01', 6),
                                                             ('BAD', 'user02', 7),
                                                             ('LIKE', 'user03', 8),
                                                             ('BAD', 'user04', 9),
                                                             ('LIKE', 'user05', 10);

INSERT INTO holidays (store_num, week, date, regular) VALUES
                                                          (1, '월', NULL, true),
                                                          (2, '월', NULL, true),
                                                          (3, '화', NULL, true),
                                                          (4, '수', NULL, true),
                                                          (5, '목', NULL, true),
                                                          (6, NULL, '2023-05-01', false),
                                                          (7, NULL, '2023-05-02', false),
                                                          (8, NULL, '2023-05-03', false),
                                                          (9, NULL, '2023-05-04', false),
                                                          (10, NULL, '2023-05-05', false);

INSERT INTO points (point_date, point_plus, point_reason, user_id) VALUES
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user01'),
                                                                       ('2023-04-02', 300, '이벤트 참여 포인트', 'user01'),
                                                                       ('2023-04-03', 200, '리뷰 작성 포인트', 'user01'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user02'),
                                                                       ('2023-04-04', 100, '추천가게 등록 포인트', 'user02'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user03'),
                                                                       ('2023-04-05', 150, '친구 추천 포인트', 'user03'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user04'),
                                                                       ('2023-04-06', 200, '리뷰 작성 포인트', 'user04'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user05'),
                                                                       ('2023-04-07', 300, '이벤트 참여 포인트', 'user05'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user06'),
                                                                       ('2023-04-08', 100, '추천가게 등록 포인트', 'user06'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user07'),
                                                                       ('2023-04-09', 150, '친구 추천 포인트', 'user07'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user08'),
                                                                       ('2023-04-10', 200, '리뷰 작성 포인트', 'user08'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user09'),
                                                                       ('2023-04-11', 300, '이벤트 참여 포인트', 'user09'),
                                                                       ('2023-04-01', 500, '회원가입 축하 포인트', 'user10'),
                                                                       ('2023-04-12', 100, '추천가게 등록 포인트', 'user10');

INSERT INTO review_replies (review_num, post_date, content)
VALUES
    (1, '2023-04-01', '감사합니다. 더욱 노력하겠습니다!'),
    (2, '2023-04-02', '좋은 평가 감사드립니다!'),
    (3, '2023-04-03', '다음에 또 방문해 주세요!'),
    (4, '2023-04-04', '고객님의 의견 반영하겠습니다.'),
    (5, '2023-04-05', '소중한 리뷰 감사합니다.'),
    (6, '2023-04-06', '늘 최선을 다하겠습니다.'),
    (7, '2023-04-07', '방문해 주셔서 감사합니다.'),
    (8, '2023-04-08', '기회가 된다면 다시 찾아주세요!'),
    (9, '2023-04-09', '맛있게 드셨다니 기쁩니다.'),
    (10, '2023-04-10', '좋은 리뷰 감사드립니다!');

INSERT INTO store_imgs (store_num, store_img) VALUES
                                                  (1, '/images/storeImg/store1_img1.jpg'),
                                                  (1, '/images/storeImg/store1_img2.jpg'),
                                                  (1, '/images/storeImg/store1_img3.jpg'),
                                                  (2, '/images/storeImg/store2_img1.jpg'),
                                                  (3, '/images/storeImg/store3_img1.jpg'),
                                                  (4, '/images/storeImg/store4_img1.jpg'),
                                                  (4, '/images/storeImg/store4_img2.jpg'),
                                                  (5, '/images/storeImg/store5_img1.jpg'),
                                                  (6, '/images/storeImg/store6_img1.jpg'),
                                                  (7, '/images/storeImg/store7_img1.jpg'),
                                                  (8, '/images/storeImg/store8_img1.jpg');

INSERT INTO chapstoryimgs (chap_num, img) VALUES
                                              (1, '/public/img/chapstory/피자.jpeg'),
                                              (2, '/public/img/chapstory/보쌈.jpeg'),
                                              (3, '/public/img/chapstory/냉면.jpeg'),
                                              (4, '/public/img/chapstory/돈까스.jpeg'),
                                              (5, '/public/img/chapstory/김밥.jpeg'),
                                              (6, '/public/img/chapstory/납작만두.jpeg'),
                                              (7, '/public/img/chapstory/떡볶이.jpeg'),
                                              (8, '/public/img/chapstory/삼겹살.jpeg'),
                                              (8, '/public/img/chapstory/삼겹살2.jpeg'),
                                              (8, '/public/img/chapstory/삼겹살3.jpeg'),
                                              (9, '/public/img/chapstory/직화쭈꾸미.jpeg'),
                                              (10, '/public/img/chapstory/찜닭.jpeg'),
                                              (11, '/public/img/chapstory/치즈폭포라볶이.jpeg'),
                                              (12, '/public/img/chapstory/감자탕.jpeg'),
                                              (13, '/public/img/chapstory/바질페스토.jpeg'),
                                              (14, '/public/img/chapstory/이자카야.jpeg'),
                                              (14, '/public/img/chapstory/이자카야2.jpeg'),
                                              (14, '/public/img/chapstory/이자카야3.jpeg'),
                                              (15, '/public/img/chapstory/양꼬치.jpeg'),
                                              (15, '/public/img/chapstory/양꼬치2.jpeg'),
                                              (16, '/public/img/chapstory/휘낭시에.jpeg'),
                                              (16, '/public/img/chapstory/휘낭시에2.jpeg'),
                                              (16, '/public/img/chapstory/휘낭시에3.jpeg'),
                                              (17, '/public/img/chapstory/김선생.jpeg'),
                                              (18, '/public/img/chapstory/맘스터치.jpeg'),
                                              (19, '/public/img/chapstory/맘스터치2.jpeg'),
                                              (19, '/public/img/chapstory/맘스터치3.jpeg'),
                                              (20, '/public/img/chapstory/묵사발.jpeg'),
                                              (21, '/public/img/chapstory/등촌칼국수.jpeg'),
                                              (21, '/public/img/chapstory/등촌칼국수2.jpeg'),
                                              (21, '/public/img/chapstory/등촌칼국수3.jpeg'),
                                              (22, '/public/img/chapstory/오코노미야끼.jpeg'),
                                              (22, '/public/img/chapstory/오코노미야끼2.jpeg'),
                                              (23, '/public/img/chapstory/라멘.jpeg'),
                                              (24, '/public/img/chapstory/타코.jpeg'),
                                              (24, '/public/img/chapstory/타코2.jpeg'),
                                              (24, '/public/img/chapstory/타코3.jpeg');

INSERT INTO chap_deals (store_num, event_title, event_condition, event_reward, event_img, event_start, event_end) VALUES
                                                                                                                      (1, '해피 아워 할인', '오후 5시부터 오후 7시 방문', '음료 50% 할인', '/images/chapdeal/event_img-1682945303920.jpg', '2023-04-16', '2023-04-25'),
                                                                                                                      (2, '주말 브런치 이벤트', '주말 브런치 메뉴 주문 시 커피 무료', '커피 1잔 무료', '/images/chapdeal/event_img-1682945358788.jpg', '2023-04-30', '2023-05-15'),
                                                                                                                      (3, '데이트 코스 할인', '데이트 코스 메뉴 주문 시 와인 무료', '와인 1병 무료', '/images/chapdeal/event_img-1682944633951.jpg', '2023-05-01', '2023-05-20'),
                                                                                                                      (4, '샐러드 데이 이벤트', '샐러드 구매 시 음료 무료', '음료수 1잔 무료', '/images/chapdeal/event_img-1682944810588.jpg', '2023-04-28', '2023-05-07'),
                                                                                                                      (5, '베이커리 세일', '빵 구매 시 커피 무료', '커피 1잔 무료', '/images/chapdeal/event_img-1682944943923.jpg', '2023-04-20', '2023-05-05'),
                                                                                                                      (5, '한정 메뉴 할인', '한정 메뉴 주문 시 디저트 무료', '디저트 1개 무료', '/images/chapdeal/event_img-1682944973518.jpg', '2023-04-26', '2023-05-12'),
                                                                                                                      (6, '스시 특별 할인', '2인분 주문 시 1인분 무료', '스시 1인분 무료', '/images/chapdeal/event_img-1682945038115.jpg', '2023-04-15', '2023-04-30'),
                                                                                                                      (8, '치킨 가족 할인', '4인분 주문 시 1인분 무료', '치킨 1인분 무료', '/images/chapdeal/event_img-1682945161872.jpg', '2023-04-18', '2023-04-28'),
                                                                                                                      (10, '피자 콤보 할인', '피자와 사이드메뉴 함께 주문', '음료수 무료', '/images/chapdeal/event_img-1682945278304.jpg', '2023-04-22', '2023-05-02'),
                                                                                                                      (10, '파스타 및 와인 이벤트', '파스타 2인분 주문 시 와인 1병 무료', '와인 1병 무료', '/images/chapdeal/event_img-1682945285951.jpg', '2023-04-24', '2023-05-09');

INSERT INTO chat_rooms(user_id, name, post_time)
VALUES
    ('user01', 'Room1', '2022-01-01 12:00:00'),
    ('user02', 'Room2', '2022-01-02 13:00:00'),
    ('user03', 'Room3', '2022-01-03 14:00:00'),
    ('user04', 'Room4', '2022-01-04 15:00:00'),
    ('user05', 'Room5', '2022-01-05 16:00:00');

INSERT INTO chat_messages(cr_id, user_id, content, status)
VALUES
    (1, 'user01',  '안녕하세요!', 'ENTER'),
    (1, 'user02',  '안녕하세요~', 'ENTER'),
    (1, 'user01', '오늘 날씨가 참 좋네요.', 'CHAT'),
    (1, 'user02', '네, 정말 좋은 날씨입니다.', 'CHAT'),
    (1, 'user01', '그렇군요.', 'CHAT'),
    (1, 'user01', '잠깐만요. 제가 문서 작업 중인데 잠시 쉬고 싶어서 나갔다가 다시 들어왔습니다.', 'LEAVE'),
    (1, 'user01', '다시 돌아왔습니다.', 'CHAT'),
    (1, 'user02', '어떤 문서 작업을 하고 있었나요?', 'CHAT'),
    (1, 'user01', '저희 회사의 신제품 출시 계획서를 작성하고 있었습니다.', 'CHAT'),
    (1, 'user02', '그런가요? 대단하십니다!', 'CHAT');

INSERT INTO chapstoryLikes (chap_num, user_id)
VALUES (1, 'user01'),
       (1, 'user02'),
       (1, 'user03'),
       (1, 'user04'),
       (1, 'user05'),
       (1, 'user06'),
       (2, 'user07'),
       (2, 'user01'),
       (2, 'user02'),
       (2, 'user03'),
       (2, 'user04'),
       (2, 'user05'),
       (2, 'user06'),
       (2, 'user07'),
       (2, 'user08'),
       (2, 'user09'),
       (2, 'user10'),
       (3, 'user03'),
       (3, 'user05'),
       (3, 'user06'),
       (4, 'user04'),
       (5, 'user05'),
       (6, 'user06'),
       (6, 'user07'),
       (6, 'user08'),
       (6, 'user09'),
       (6, 'user10'),
       (6, 'user11'),
       (6, 'user12'),
       (7, 'user07'),
       (8, 'user08'),
       (9, 'user09'),
       (10, 'user10'),
       (11, 'user11'),
       (12, 'user12'),
       (14, 'user14'),
       (15, 'user15'),
       (16, 'user16'),
       (17, 'user17'),
       (18, 'user18'),
       (19, 'user19'),
       (20, 'user20');


# 여기부터 988개 store_manages, store, storetypes
INSERT INTO store_manages (store_id, pw, business_num, store_call, phone, email) VALUES
                                                                                     ('store0001', '1234', '1879259064', '02-1234-5678', '010-1111-2222', 'store0001@naver.com'),
                                                                                     ('store0002', '1234', '1727002392', '02-1234-5678', '010-1111-2222', 'store0002@naver.com'),
                                                                                     ('store0003', '1234', '1110585448', '02-1234-5678', '010-1111-2222', 'store0003@naver.com'),
                                                                                     ('store0004', '1234', '1349558988', '02-1234-5678', '010-1111-2222', 'store0004@naver.com'),
                                                                                     ('store0005', '1234', '1000518213', '02-1234-5678', '010-1111-2222', 'store0005@naver.com'),
                                                                                     ('store0006', '1234', '1420052767', '02-1234-5678', '010-1111-2222', 'store0006@naver.com'),
                                                                                     ('store0007', '1234', '1780735372', '02-1234-5678', '010-1111-2222', 'store0007@naver.com'),
                                                                                     ('store0008', '1234', '0583843577', '02-1234-5678', '010-1111-2222', 'store0008@naver.com'),
                                                                                     ('store0009', '1234', '1100466653', '02-1234-5678', '010-1111-2222', 'store0009@naver.com'),
                                                                                     ('store0010', '1234', '1879934722', '02-1234-5678', '010-1111-2222', 'store0010@naver.com'),
                                                                                     ('store0011', '1234', '0430612306', '02-1234-5678', '010-1111-2222', 'store0011@naver.com'),
                                                                                     ('store0012', '1234', '0908954636', '02-1234-5678', '010-1111-2222', 'store0012@naver.com'),
                                                                                     ('store0013', '1234', '1081399760', '02-1234-5678', '010-1111-2222', 'store0013@naver.com'),
                                                                                     ('store0014', '1234', '0298516196', '02-1234-5678', '010-1111-2222', 'store0014@naver.com'),
                                                                                     ('store0015', '1234', '0250079450', '02-1234-5678', '010-1111-2222', 'store0015@naver.com'),
                                                                                     ('store0016', '1234', '1605451067', '02-1234-5678', '010-1111-2222', 'store0016@naver.com'),
                                                                                     ('store0017', '1234', '1309153378', '02-1234-5678', '010-1111-2222', 'store0017@naver.com'),
                                                                                     ('store0018', '1234', '1894754062', '02-1234-5678', '010-1111-2222', 'store0018@naver.com'),
                                                                                     ('store0019', '1234', '0769869359', '02-1234-5678', '010-1111-2222', 'store0019@naver.com'),
                                                                                     ('store0020', '1234', '1347641501', '02-1234-5678', '010-1111-2222', 'store0020@naver.com'),
                                                                                     ('store0021', '1234', '0858071938', '02-1234-5678', '010-1111-2222', 'store0021@naver.com'),
                                                                                     ('store0022', '1234', '1260476549', '02-1234-5678', '010-1111-2222', 'store0022@naver.com'),
                                                                                     ('store0023', '1234', '0913615833', '02-1234-5678', '010-1111-2222', 'store0023@naver.com'),
                                                                                     ('store0024', '1234', '0063302733', '02-1234-5678', '010-1111-2222', 'store0024@naver.com'),
                                                                                     ('store0025', '1234', '0781932469', '02-1234-5678', '010-1111-2222', 'store0025@naver.com'),
                                                                                     ('store0026', '1234', '1306712388', '02-1234-5678', '010-1111-2222', 'store0026@naver.com'),
                                                                                     ('store0027', '1234', '1467149711', '02-1234-5678', '010-1111-2222', 'store0027@naver.com'),
                                                                                     ('store0028', '1234', '1911927863', '02-1234-5678', '010-1111-2222', 'store0028@naver.com'),
                                                                                     ('store0029', '1234', '1319596818', '02-1234-5678', '010-1111-2222', 'store0029@naver.com'),
                                                                                     ('store0030', '1234', '1178734619', '02-1234-5678', '010-1111-2222', 'store0030@naver.com'),
                                                                                     ('store0031', '1234', '1466805769', '02-1234-5678', '010-1111-2222', 'store0031@naver.com'),
                                                                                     ('store0032', '1234', '0625226370', '02-1234-5678', '010-1111-2222', 'store0032@naver.com'),
                                                                                     ('store0033', '1234', '2136286822', '02-1234-5678', '010-1111-2222', 'store0033@naver.com'),
                                                                                     ('store0034', '1234', '0807361572', '02-1234-5678', '010-1111-2222', 'store0034@naver.com'),
                                                                                     ('store0035', '1234', '0522009076', '02-1234-5678', '010-1111-2222', 'store0035@naver.com'),
                                                                                     ('store0036', '1234', '1576348826', '02-1234-5678', '010-1111-2222', 'store0036@naver.com'),
                                                                                     ('store0037', '1234', '1940739703', '02-1234-5678', '010-1111-2222', 'store0037@naver.com'),
                                                                                     ('store0038', '1234', '1918413277', '02-1234-5678', '010-1111-2222', 'store0038@naver.com'),
                                                                                     ('store0039', '1234', '0212328447', '02-1234-5678', '010-1111-2222', 'store0039@naver.com'),
                                                                                     ('store0040', '1234', '0544038616', '02-1234-5678', '010-1111-2222', 'store0040@naver.com'),
                                                                                     ('store0041', '1234', '0827846502', '02-1234-5678', '010-1111-2222', 'store0041@naver.com'),
                                                                                     ('store0042', '1234', '0284327911', '02-1234-5678', '010-1111-2222', 'store0042@naver.com'),
                                                                                     ('store0043', '1234', '0939751443', '02-1234-5678', '010-1111-2222', 'store0043@naver.com'),
                                                                                     ('store0044', '1234', '1883764945', '02-1234-5678', '010-1111-2222', 'store0044@naver.com'),
                                                                                     ('store0045', '1234', '1185172526', '02-1234-5678', '010-1111-2222', 'store0045@naver.com'),
                                                                                     ('store0046', '1234', '1669520730', '02-1234-5678', '010-1111-2222', 'store0046@naver.com'),
                                                                                     ('store0047', '1234', '0691202975', '02-1234-5678', '010-1111-2222', 'store0047@naver.com'),
                                                                                     ('store0048', '1234', '2023445560', '02-1234-5678', '010-1111-2222', 'store0048@naver.com'),
                                                                                     ('store0049', '1234', '0936989769', '02-1234-5678', '010-1111-2222', 'store0049@naver.com'),
                                                                                     ('store0050', '1234', '1749377987', '02-1234-5678', '010-1111-2222', 'store0050@naver.com'),
                                                                                     ('store0051', '1234', '1409986833', '02-1234-5678', '010-1111-2222', 'store0051@naver.com'),
                                                                                     ('store0052', '1234', '1856106608', '02-1234-5678', '010-1111-2222', 'store0052@naver.com'),
                                                                                     ('store0053', '1234', '1650364785', '02-1234-5678', '010-1111-2222', 'store0053@naver.com'),
                                                                                     ('store0054', '1234', '0821946043', '02-1234-5678', '010-1111-2222', 'store0054@naver.com'),
                                                                                     ('store0055', '1234', '1873038432', '02-1234-5678', '010-1111-2222', 'store0055@naver.com'),
                                                                                     ('store0056', '1234', '0906190003', '02-1234-5678', '010-1111-2222', 'store0056@naver.com'),
                                                                                     ('store0057', '1234', '1021419396', '02-1234-5678', '010-1111-2222', 'store0057@naver.com'),
                                                                                     ('store0058', '1234', '1975917349', '02-1234-5678', '010-1111-2222', 'store0058@naver.com'),
                                                                                     ('store0059', '1234', '0416810694', '02-1234-5678', '010-1111-2222', 'store0059@naver.com'),
                                                                                     ('store0060', '1234', '0499735256', '02-1234-5678', '010-1111-2222', 'store0060@naver.com'),
                                                                                     ('store0061', '1234', '1194293376', '02-1234-5678', '010-1111-2222', 'store0061@naver.com'),
                                                                                     ('store0062', '1234', '1018478595', '02-1234-5678', '010-1111-2222', 'store0062@naver.com'),
                                                                                     ('store0063', '1234', '0404041611', '02-1234-5678', '010-1111-2222', 'store0063@naver.com'),
                                                                                     ('store0064', '1234', '1162355908', '02-1234-5678', '010-1111-2222', 'store0064@naver.com'),
                                                                                     ('store0065', '1234', '0422526638', '02-1234-5678', '010-1111-2222', 'store0065@naver.com'),
                                                                                     ('store0066', '1234', '1603812085', '02-1234-5678', '010-1111-2222', 'store0066@naver.com'),
                                                                                     ('store0067', '1234', '0115628029', '02-1234-5678', '010-1111-2222', 'store0067@naver.com'),
                                                                                     ('store0068', '1234', '0897932912', '02-1234-5678', '010-1111-2222', 'store0068@naver.com'),
                                                                                     ('store0069', '1234', '2120500956', '02-1234-5678', '010-1111-2222', 'store0069@naver.com'),
                                                                                     ('store0070', '1234', '1214530128', '02-1234-5678', '010-1111-2222', 'store0070@naver.com'),
                                                                                     ('store0071', '1234', '1835277436', '02-1234-5678', '010-1111-2222', 'store0071@naver.com'),
                                                                                     ('store0072', '1234', '0077061778', '02-1234-5678', '010-1111-2222', 'store0072@naver.com'),
                                                                                     ('store0073', '1234', '2092385474', '02-1234-5678', '010-1111-2222', 'store0073@naver.com'),
                                                                                     ('store0074', '1234', '2031210199', '02-1234-5678', '010-1111-2222', 'store0074@naver.com'),
                                                                                     ('store0075', '1234', '1934109873', '02-1234-5678', '010-1111-2222', 'store0075@naver.com'),
                                                                                     ('store0076', '1234', '1035147243', '02-1234-5678', '010-1111-2222', 'store0076@naver.com'),
                                                                                     ('store0077', '1234', '0505584518', '02-1234-5678', '010-1111-2222', 'store0077@naver.com'),
                                                                                     ('store0078', '1234', '0774516505', '02-1234-5678', '010-1111-2222', 'store0078@naver.com'),
                                                                                     ('store0079', '1234', '1802200287', '02-1234-5678', '010-1111-2222', 'store0079@naver.com'),
                                                                                     ('store0080', '1234', '0078875948', '02-1234-5678', '010-1111-2222', 'store0080@naver.com'),
                                                                                     ('store0081', '1234', '0190575707', '02-1234-5678', '010-1111-2222', 'store0081@naver.com'),
                                                                                     ('store0082', '1234', '1873393254', '02-1234-5678', '010-1111-2222', 'store0082@naver.com'),
                                                                                     ('store0083', '1234', '1208019538', '02-1234-5678', '010-1111-2222', 'store0083@naver.com'),
                                                                                     ('store0084', '1234', '1135499654', '02-1234-5678', '010-1111-2222', 'store0084@naver.com'),
                                                                                     ('store0085', '1234', '1909808452', '02-1234-5678', '010-1111-2222', 'store0085@naver.com'),
                                                                                     ('store0086', '1234', '0401875311', '02-1234-5678', '010-1111-2222', 'store0086@naver.com'),
                                                                                     ('store0087', '1234', '1828543731', '02-1234-5678', '010-1111-2222', 'store0087@naver.com'),
                                                                                     ('store0088', '1234', '0316438477', '02-1234-5678', '010-1111-2222', 'store0088@naver.com'),
                                                                                     ('store0089', '1234', '0731009527', '02-1234-5678', '010-1111-2222', 'store0089@naver.com'),
                                                                                     ('store0090', '1234', '1541171833', '02-1234-5678', '010-1111-2222', 'store0090@naver.com'),
                                                                                     ('store0091', '1234', '0361779197', '02-1234-5678', '010-1111-2222', 'store0091@naver.com'),
                                                                                     ('store0092', '1234', '0802886215', '02-1234-5678', '010-1111-2222', 'store0092@naver.com'),
                                                                                     ('store0093', '1234', '0124858588', '02-1234-5678', '010-1111-2222', 'store0093@naver.com'),
                                                                                     ('store0094', '1234', '0719546174', '02-1234-5678', '010-1111-2222', 'store0094@naver.com'),
                                                                                     ('store0095', '1234', '0563567562', '02-1234-5678', '010-1111-2222', 'store0095@naver.com'),
                                                                                     ('store0096', '1234', '1665451287', '02-1234-5678', '010-1111-2222', 'store0096@naver.com'),
                                                                                     ('store0097', '1234', '1657781813', '02-1234-5678', '010-1111-2222', 'store0097@naver.com'),
                                                                                     ('store0098', '1234', '1198271072', '02-1234-5678', '010-1111-2222', 'store0098@naver.com'),
                                                                                     ('store0099', '1234', '0469187271', '02-1234-5678', '010-1111-2222', 'store0099@naver.com'),
                                                                                     ('store0100', '1234', '1337744705', '02-1234-5678', '010-1111-2222', 'store0100@naver.com'),
                                                                                     ('store0101', '1234', '1106868055', '02-1234-5678', '010-1111-2222', 'store0101@naver.com'),
                                                                                     ('store0102', '1234', '1230684811', '02-1234-5678', '010-1111-2222', 'store0102@naver.com'),
                                                                                     ('store0103', '1234', '0802980743', '02-1234-5678', '010-1111-2222', 'store0103@naver.com'),
                                                                                     ('store0104', '1234', '0708853337', '02-1234-5678', '010-1111-2222', 'store0104@naver.com'),
                                                                                     ('store0105', '1234', '1572378646', '02-1234-5678', '010-1111-2222', 'store0105@naver.com'),
                                                                                     ('store0106', '1234', '0570528038', '02-1234-5678', '010-1111-2222', 'store0106@naver.com'),
                                                                                     ('store0107', '1234', '1345106419', '02-1234-5678', '010-1111-2222', 'store0107@naver.com'),
                                                                                     ('store0108', '1234', '1772501197', '02-1234-5678', '010-1111-2222', 'store0108@naver.com'),
                                                                                     ('store0109', '1234', '1439618111', '02-1234-5678', '010-1111-2222', 'store0109@naver.com'),
                                                                                     ('store0110', '1234', '1342902965', '02-1234-5678', '010-1111-2222', 'store0110@naver.com'),
                                                                                     ('store0111', '1234', '0453595550', '02-1234-5678', '010-1111-2222', 'store0111@naver.com'),
                                                                                     ('store0112', '1234', '0487733963', '02-1234-5678', '010-1111-2222', 'store0112@naver.com'),
                                                                                     ('store0113', '1234', '0673769278', '02-1234-5678', '010-1111-2222', 'store0113@naver.com'),
                                                                                     ('store0114', '1234', '1490129614', '02-1234-5678', '010-1111-2222', 'store0114@naver.com'),
                                                                                     ('store0115', '1234', '0106052406', '02-1234-5678', '010-1111-2222', 'store0115@naver.com'),
                                                                                     ('store0116', '1234', '1672930768', '02-1234-5678', '010-1111-2222', 'store0116@naver.com'),
                                                                                     ('store0117', '1234', '0997211104', '02-1234-5678', '010-1111-2222', 'store0117@naver.com'),
                                                                                     ('store0118', '1234', '0133424565', '02-1234-5678', '010-1111-2222', 'store0118@naver.com'),
                                                                                     ('store0119', '1234', '0917567254', '02-1234-5678', '010-1111-2222', 'store0119@naver.com'),
                                                                                     ('store0120', '1234', '0836088527', '02-1234-5678', '010-1111-2222', 'store0120@naver.com'),
                                                                                     ('store0121', '1234', '0592449075', '02-1234-5678', '010-1111-2222', 'store0121@naver.com'),
                                                                                     ('store0122', '1234', '1435361687', '02-1234-5678', '010-1111-2222', 'store0122@naver.com'),
                                                                                     ('store0123', '1234', '1342600953', '02-1234-5678', '010-1111-2222', 'store0123@naver.com'),
                                                                                     ('store0124', '1234', '0811921146', '02-1234-5678', '010-1111-2222', 'store0124@naver.com'),
                                                                                     ('store0125', '1234', '0829917578', '02-1234-5678', '010-1111-2222', 'store0125@naver.com'),
                                                                                     ('store0126', '1234', '1894576479', '02-1234-5678', '010-1111-2222', 'store0126@naver.com'),
                                                                                     ('store0127', '1234', '0758479050', '02-1234-5678', '010-1111-2222', 'store0127@naver.com'),
                                                                                     ('store0128', '1234', '0144472879', '02-1234-5678', '010-1111-2222', 'store0128@naver.com'),
                                                                                     ('store0129', '1234', '1983415453', '02-1234-5678', '010-1111-2222', 'store0129@naver.com'),
                                                                                     ('store0130', '1234', '0210025273', '02-1234-5678', '010-1111-2222', 'store0130@naver.com'),
                                                                                     ('store0131', '1234', '1230439575', '02-1234-5678', '010-1111-2222', 'store0131@naver.com'),
                                                                                     ('store0132', '1234', '1334761474', '02-1234-5678', '010-1111-2222', 'store0132@naver.com'),
                                                                                     ('store0133', '1234', '1455070669', '02-1234-5678', '010-1111-2222', 'store0133@naver.com'),
                                                                                     ('store0134', '1234', '0099447969', '02-1234-5678', '010-1111-2222', 'store0134@naver.com'),
                                                                                     ('store0135', '1234', '1519097763', '02-1234-5678', '010-1111-2222', 'store0135@naver.com'),
                                                                                     ('store0136', '1234', '0780314723', '02-1234-5678', '010-1111-2222', 'store0136@naver.com'),
                                                                                     ('store0137', '1234', '0120887684', '02-1234-5678', '010-1111-2222', 'store0137@naver.com'),
                                                                                     ('store0138', '1234', '2037718567', '02-1234-5678', '010-1111-2222', 'store0138@naver.com'),
                                                                                     ('store0139', '1234', '2113056410', '02-1234-5678', '010-1111-2222', 'store0139@naver.com'),
                                                                                     ('store0140', '1234', '1134130412', '02-1234-5678', '010-1111-2222', 'store0140@naver.com'),
                                                                                     ('store0141', '1234', '0966395067', '02-1234-5678', '010-1111-2222', 'store0141@naver.com'),
                                                                                     ('store0142', '1234', '0770080961', '02-1234-5678', '010-1111-2222', 'store0142@naver.com'),
                                                                                     ('store0143', '1234', '2113634527', '02-1234-5678', '010-1111-2222', 'store0143@naver.com'),
                                                                                     ('store0144', '1234', '1712527818', '02-1234-5678', '010-1111-2222', 'store0144@naver.com'),
                                                                                     ('store0145', '1234', '0046742933', '02-1234-5678', '010-1111-2222', 'store0145@naver.com'),
                                                                                     ('store0146', '1234', '1983669964', '02-1234-5678', '010-1111-2222', 'store0146@naver.com'),
                                                                                     ('store0147', '1234', '1130159873', '02-1234-5678', '010-1111-2222', 'store0147@naver.com'),
                                                                                     ('store0148', '1234', '1590290757', '02-1234-5678', '010-1111-2222', 'store0148@naver.com'),
                                                                                     ('store0149', '1234', '1906713641', '02-1234-5678', '010-1111-2222', 'store0149@naver.com'),
                                                                                     ('store0150', '1234', '0832907937', '02-1234-5678', '010-1111-2222', 'store0150@naver.com'),
                                                                                     ('store0151', '1234', '0179258957', '02-1234-5678', '010-1111-2222', 'store0151@naver.com'),
                                                                                     ('store0152', '1234', '1325018349', '02-1234-5678', '010-1111-2222', 'store0152@naver.com'),
                                                                                     ('store0153', '1234', '0248501597', '02-1234-5678', '010-1111-2222', 'store0153@naver.com'),
                                                                                     ('store0154', '1234', '0908219600', '02-1234-5678', '010-1111-2222', 'store0154@naver.com'),
                                                                                     ('store0155', '1234', '1543723901', '02-1234-5678', '010-1111-2222', 'store0155@naver.com'),
                                                                                     ('store0156', '1234', '1168658275', '02-1234-5678', '010-1111-2222', 'store0156@naver.com'),
                                                                                     ('store0157', '1234', '1961095661', '02-1234-5678', '010-1111-2222', 'store0157@naver.com'),
                                                                                     ('store0158', '1234', '1221698556', '02-1234-5678', '010-1111-2222', 'store0158@naver.com'),
                                                                                     ('store0159', '1234', '0671096462', '02-1234-5678', '010-1111-2222', 'store0159@naver.com'),
                                                                                     ('store0160', '1234', '0698587329', '02-1234-5678', '010-1111-2222', 'store0160@naver.com'),
                                                                                     ('store0161', '1234', '0111678347', '02-1234-5678', '010-1111-2222', 'store0161@naver.com'),
                                                                                     ('store0162', '1234', '1680373843', '02-1234-5678', '010-1111-2222', 'store0162@naver.com'),
                                                                                     ('store0163', '1234', '1916225967', '02-1234-5678', '010-1111-2222', 'store0163@naver.com'),
                                                                                     ('store0164', '1234', '1876428711', '02-1234-5678', '010-1111-2222', 'store0164@naver.com'),
                                                                                     ('store0165', '1234', '1511666209', '02-1234-5678', '010-1111-2222', 'store0165@naver.com'),
                                                                                     ('store0166', '1234', '0499137703', '02-1234-5678', '010-1111-2222', 'store0166@naver.com'),
                                                                                     ('store0167', '1234', '1066626389', '02-1234-5678', '010-1111-2222', 'store0167@naver.com'),
                                                                                     ('store0168', '1234', '0167801059', '02-1234-5678', '010-1111-2222', 'store0168@naver.com'),
                                                                                     ('store0169', '1234', '2138233650', '02-1234-5678', '010-1111-2222', 'store0169@naver.com'),
                                                                                     ('store0170', '1234', '1784809262', '02-1234-5678', '010-1111-2222', 'store0170@naver.com'),
                                                                                     ('store0171', '1234', '2032827244', '02-1234-5678', '010-1111-2222', 'store0171@naver.com'),
                                                                                     ('store0172', '1234', '1366470588', '02-1234-5678', '010-1111-2222', 'store0172@naver.com'),
                                                                                     ('store0173', '1234', '0498089310', '02-1234-5678', '010-1111-2222', 'store0173@naver.com'),
                                                                                     ('store0174', '1234', '0157895635', '02-1234-5678', '010-1111-2222', 'store0174@naver.com'),
                                                                                     ('store0175', '1234', '1215861671', '02-1234-5678', '010-1111-2222', 'store0175@naver.com'),
                                                                                     ('store0176', '1234', '0391270619', '02-1234-5678', '010-1111-2222', 'store0176@naver.com'),
                                                                                     ('store0177', '1234', '1500457476', '02-1234-5678', '010-1111-2222', 'store0177@naver.com'),
                                                                                     ('store0178', '1234', '1140398646', '02-1234-5678', '010-1111-2222', 'store0178@naver.com'),
                                                                                     ('store0179', '1234', '1160905464', '02-1234-5678', '010-1111-2222', 'store0179@naver.com'),
                                                                                     ('store0180', '1234', '0731038167', '02-1234-5678', '010-1111-2222', 'store0180@naver.com'),
                                                                                     ('store0181', '1234', '1187467009', '02-1234-5678', '010-1111-2222', 'store0181@naver.com'),
                                                                                     ('store0182', '1234', '1048379719', '02-1234-5678', '010-1111-2222', 'store0182@naver.com'),
                                                                                     ('store0183', '1234', '1402505244', '02-1234-5678', '010-1111-2222', 'store0183@naver.com'),
                                                                                     ('store0184', '1234', '1970843483', '02-1234-5678', '010-1111-2222', 'store0184@naver.com'),
                                                                                     ('store0185', '1234', '1303513751', '02-1234-5678', '010-1111-2222', 'store0185@naver.com'),
                                                                                     ('store0186', '1234', '1797673594', '02-1234-5678', '010-1111-2222', 'store0186@naver.com'),
                                                                                     ('store0187', '1234', '0867110734', '02-1234-5678', '010-1111-2222', 'store0187@naver.com'),
                                                                                     ('store0188', '1234', '1264245750', '02-1234-5678', '010-1111-2222', 'store0188@naver.com'),
                                                                                     ('store0189', '1234', '1985436522', '02-1234-5678', '010-1111-2222', 'store0189@naver.com'),
                                                                                     ('store0190', '1234', '0606609063', '02-1234-5678', '010-1111-2222', 'store0190@naver.com'),
                                                                                     ('store0191', '1234', '0921188123', '02-1234-5678', '010-1111-2222', 'store0191@naver.com'),
                                                                                     ('store0192', '1234', '0652040575', '02-1234-5678', '010-1111-2222', 'store0192@naver.com'),
                                                                                     ('store0193', '1234', '0898797220', '02-1234-5678', '010-1111-2222', 'store0193@naver.com'),
                                                                                     ('store0194', '1234', '2013259394', '02-1234-5678', '010-1111-2222', 'store0194@naver.com'),
                                                                                     ('store0195', '1234', '0102699093', '02-1234-5678', '010-1111-2222', 'store0195@naver.com'),
                                                                                     ('store0196', '1234', '0996585251', '02-1234-5678', '010-1111-2222', 'store0196@naver.com'),
                                                                                     ('store0197', '1234', '2050518583', '02-1234-5678', '010-1111-2222', 'store0197@naver.com'),
                                                                                     ('store0198', '1234', '1052678322', '02-1234-5678', '010-1111-2222', 'store0198@naver.com'),
                                                                                     ('store0199', '1234', '0300854049', '02-1234-5678', '010-1111-2222', 'store0199@naver.com'),
                                                                                     ('store0200', '1234', '0482153997', '02-1234-5678', '010-1111-2222', 'store0200@naver.com'),
                                                                                     ('store0201', '1234', '0994234690', '02-1234-5678', '010-1111-2222', 'store0201@naver.com'),
                                                                                     ('store0202', '1234', '1554323344', '02-1234-5678', '010-1111-2222', 'store0202@naver.com'),
                                                                                     ('store0203', '1234', '0586425132', '02-1234-5678', '010-1111-2222', 'store0203@naver.com'),
                                                                                     ('store0204', '1234', '0473077424', '02-1234-5678', '010-1111-2222', 'store0204@naver.com'),
                                                                                     ('store0205', '1234', '1914802317', '02-1234-5678', '010-1111-2222', 'store0205@naver.com'),
                                                                                     ('store0206', '1234', '0908140669', '02-1234-5678', '010-1111-2222', 'store0206@naver.com'),
                                                                                     ('store0207', '1234', '1196424442', '02-1234-5678', '010-1111-2222', 'store0207@naver.com'),
                                                                                     ('store0208', '1234', '1177120948', '02-1234-5678', '010-1111-2222', 'store0208@naver.com'),
                                                                                     ('store0209', '1234', '0959381807', '02-1234-5678', '010-1111-2222', 'store0209@naver.com'),
                                                                                     ('store0210', '1234', '1458245344', '02-1234-5678', '010-1111-2222', 'store0210@naver.com'),
                                                                                     ('store0211', '1234', '1106691678', '02-1234-5678', '010-1111-2222', 'store0211@naver.com'),
                                                                                     ('store0212', '1234', '2091308923', '02-1234-5678', '010-1111-2222', 'store0212@naver.com'),
                                                                                     ('store0213', '1234', '1824929615', '02-1234-5678', '010-1111-2222', 'store0213@naver.com'),
                                                                                     ('store0214', '1234', '1330812091', '02-1234-5678', '010-1111-2222', 'store0214@naver.com'),
                                                                                     ('store0215', '1234', '1814957062', '02-1234-5678', '010-1111-2222', 'store0215@naver.com'),
                                                                                     ('store0216', '1234', '1019260238', '02-1234-5678', '010-1111-2222', 'store0216@naver.com'),
                                                                                     ('store0217', '1234', '1205564167', '02-1234-5678', '010-1111-2222', 'store0217@naver.com'),
                                                                                     ('store0218', '1234', '0793780969', '02-1234-5678', '010-1111-2222', 'store0218@naver.com'),
                                                                                     ('store0219', '1234', '0554817070', '02-1234-5678', '010-1111-2222', 'store0219@naver.com'),
                                                                                     ('store0220', '1234', '0613648169', '02-1234-5678', '010-1111-2222', 'store0220@naver.com'),
                                                                                     ('store0221', '1234', '0526072164', '02-1234-5678', '010-1111-2222', 'store0221@naver.com'),
                                                                                     ('store0222', '1234', '0139614966', '02-1234-5678', '010-1111-2222', 'store0222@naver.com'),
                                                                                     ('store0223', '1234', '0391118453', '02-1234-5678', '010-1111-2222', 'store0223@naver.com'),
                                                                                     ('store0224', '1234', '0817423135', '02-1234-5678', '010-1111-2222', 'store0224@naver.com'),
                                                                                     ('store0225', '1234', '1478146954', '02-1234-5678', '010-1111-2222', 'store0225@naver.com'),
                                                                                     ('store0226', '1234', '0815432858', '02-1234-5678', '010-1111-2222', 'store0226@naver.com'),
                                                                                     ('store0227', '1234', '0965333197', '02-1234-5678', '010-1111-2222', 'store0227@naver.com'),
                                                                                     ('store0228', '1234', '1334451051', '02-1234-5678', '010-1111-2222', 'store0228@naver.com'),
                                                                                     ('store0229', '1234', '2045529589', '02-1234-5678', '010-1111-2222', 'store0229@naver.com'),
                                                                                     ('store0230', '1234', '1928372436', '02-1234-5678', '010-1111-2222', 'store0230@naver.com'),
                                                                                     ('store0231', '1234', '1730251147', '02-1234-5678', '010-1111-2222', 'store0231@naver.com'),
                                                                                     ('store0232', '1234', '1820016661', '02-1234-5678', '010-1111-2222', 'store0232@naver.com'),
                                                                                     ('store0233', '1234', '0966054362', '02-1234-5678', '010-1111-2222', 'store0233@naver.com'),
                                                                                     ('store0234', '1234', '1797739680', '02-1234-5678', '010-1111-2222', 'store0234@naver.com'),
                                                                                     ('store0235', '1234', '0213934750', '02-1234-5678', '010-1111-2222', 'store0235@naver.com'),
                                                                                     ('store0236', '1234', '1461821757', '02-1234-5678', '010-1111-2222', 'store0236@naver.com'),
                                                                                     ('store0237', '1234', '1594561195', '02-1234-5678', '010-1111-2222', 'store0237@naver.com'),
                                                                                     ('store0238', '1234', '1827767636', '02-1234-5678', '010-1111-2222', 'store0238@naver.com'),
                                                                                     ('store0239', '1234', '0112919004', '02-1234-5678', '010-1111-2222', 'store0239@naver.com'),
                                                                                     ('store0240', '1234', '0850162696', '02-1234-5678', '010-1111-2222', 'store0240@naver.com'),
                                                                                     ('store0241', '1234', '0330840506', '02-1234-5678', '010-1111-2222', 'store0241@naver.com'),
                                                                                     ('store0242', '1234', '1385111709', '02-1234-5678', '010-1111-2222', 'store0242@naver.com'),
                                                                                     ('store0243', '1234', '0046479992', '02-1234-5678', '010-1111-2222', 'store0243@naver.com'),
                                                                                     ('store0244', '1234', '1079155748', '02-1234-5678', '010-1111-2222', 'store0244@naver.com'),
                                                                                     ('store0245', '1234', '0763402741', '02-1234-5678', '010-1111-2222', 'store0245@naver.com'),
                                                                                     ('store0246', '1234', '1769220624', '02-1234-5678', '010-1111-2222', 'store0246@naver.com'),
                                                                                     ('store0247', '1234', '1866675088', '02-1234-5678', '010-1111-2222', 'store0247@naver.com'),
                                                                                     ('store0248', '1234', '1478444025', '02-1234-5678', '010-1111-2222', 'store0248@naver.com'),
                                                                                     ('store0249', '1234', '0558773711', '02-1234-5678', '010-1111-2222', 'store0249@naver.com'),
                                                                                     ('store0250', '1234', '0333760623', '02-1234-5678', '010-1111-2222', 'store0250@naver.com'),
                                                                                     ('store0251', '1234', '2081760739', '02-1234-5678', '010-1111-2222', 'store0251@naver.com'),
                                                                                     ('store0252', '1234', '0137858413', '02-1234-5678', '010-1111-2222', 'store0252@naver.com'),
                                                                                     ('store0253', '1234', '0382370112', '02-1234-5678', '010-1111-2222', 'store0253@naver.com'),
                                                                                     ('store0254', '1234', '0691186811', '02-1234-5678', '010-1111-2222', 'store0254@naver.com'),
                                                                                     ('store0255', '1234', '0471597728', '02-1234-5678', '010-1111-2222', 'store0255@naver.com'),
                                                                                     ('store0256', '1234', '1305363796', '02-1234-5678', '010-1111-2222', 'store0256@naver.com'),
                                                                                     ('store0257', '1234', '1829437922', '02-1234-5678', '010-1111-2222', 'store0257@naver.com'),
                                                                                     ('store0258', '1234', '0645122928', '02-1234-5678', '010-1111-2222', 'store0258@naver.com'),
                                                                                     ('store0259', '1234', '0587756889', '02-1234-5678', '010-1111-2222', 'store0259@naver.com'),
                                                                                     ('store0260', '1234', '1763648371', '02-1234-5678', '010-1111-2222', 'store0260@naver.com'),
                                                                                     ('store0261', '1234', '1833733948', '02-1234-5678', '010-1111-2222', 'store0261@naver.com'),
                                                                                     ('store0262', '1234', '2094008098', '02-1234-5678', '010-1111-2222', 'store0262@naver.com'),
                                                                                     ('store0263', '1234', '1701499670', '02-1234-5678', '010-1111-2222', 'store0263@naver.com'),
                                                                                     ('store0264', '1234', '1436139823', '02-1234-5678', '010-1111-2222', 'store0264@naver.com'),
                                                                                     ('store0265', '1234', '1603474716', '02-1234-5678', '010-1111-2222', 'store0265@naver.com'),
                                                                                     ('store0266', '1234', '0277020082', '02-1234-5678', '010-1111-2222', 'store0266@naver.com'),
                                                                                     ('store0267', '1234', '0949069958', '02-1234-5678', '010-1111-2222', 'store0267@naver.com'),
                                                                                     ('store0268', '1234', '0561844439', '02-1234-5678', '010-1111-2222', 'store0268@naver.com'),
                                                                                     ('store0269', '1234', '0692050461', '02-1234-5678', '010-1111-2222', 'store0269@naver.com'),
                                                                                     ('store0270', '1234', '2114509549', '02-1234-5678', '010-1111-2222', 'store0270@naver.com'),
                                                                                     ('store0271', '1234', '0900577617', '02-1234-5678', '010-1111-2222', 'store0271@naver.com'),
                                                                                     ('store0272', '1234', '1462157195', '02-1234-5678', '010-1111-2222', 'store0272@naver.com'),
                                                                                     ('store0273', '1234', '0630090825', '02-1234-5678', '010-1111-2222', 'store0273@naver.com'),
                                                                                     ('store0274', '1234', '0624993601', '02-1234-5678', '010-1111-2222', 'store0274@naver.com'),
                                                                                     ('store0275', '1234', '0185426569', '02-1234-5678', '010-1111-2222', 'store0275@naver.com'),
                                                                                     ('store0276', '1234', '0182881223', '02-1234-5678', '010-1111-2222', 'store0276@naver.com'),
                                                                                     ('store0277', '1234', '1535669719', '02-1234-5678', '010-1111-2222', 'store0277@naver.com'),
                                                                                     ('store0278', '1234', '0305930332', '02-1234-5678', '010-1111-2222', 'store0278@naver.com'),
                                                                                     ('store0279', '1234', '1412330046', '02-1234-5678', '010-1111-2222', 'store0279@naver.com'),
                                                                                     ('store0280', '1234', '0953957008', '02-1234-5678', '010-1111-2222', 'store0280@naver.com'),
                                                                                     ('store0281', '1234', '1317198869', '02-1234-5678', '010-1111-2222', 'store0281@naver.com'),
                                                                                     ('store0282', '1234', '0547159907', '02-1234-5678', '010-1111-2222', 'store0282@naver.com'),
                                                                                     ('store0283', '1234', '2097456688', '02-1234-5678', '010-1111-2222', 'store0283@naver.com'),
                                                                                     ('store0284', '1234', '0132609337', '02-1234-5678', '010-1111-2222', 'store0284@naver.com'),
                                                                                     ('store0285', '1234', '0565881441', '02-1234-5678', '010-1111-2222', 'store0285@naver.com'),
                                                                                     ('store0286', '1234', '0039895243', '02-1234-5678', '010-1111-2222', 'store0286@naver.com'),
                                                                                     ('store0287', '1234', '0121906079', '02-1234-5678', '010-1111-2222', 'store0287@naver.com'),
                                                                                     ('store0288', '1234', '1134262738', '02-1234-5678', '010-1111-2222', 'store0288@naver.com'),
                                                                                     ('store0289', '1234', '0055470929', '02-1234-5678', '010-1111-2222', 'store0289@naver.com'),
                                                                                     ('store0290', '1234', '2037919192', '02-1234-5678', '010-1111-2222', 'store0290@naver.com'),
                                                                                     ('store0291', '1234', '2095209023', '02-1234-5678', '010-1111-2222', 'store0291@naver.com'),
                                                                                     ('store0292', '1234', '2082285614', '02-1234-5678', '010-1111-2222', 'store0292@naver.com'),
                                                                                     ('store0293', '1234', '1857597939', '02-1234-5678', '010-1111-2222', 'store0293@naver.com'),
                                                                                     ('store0294', '1234', '0035461040', '02-1234-5678', '010-1111-2222', 'store0294@naver.com'),
                                                                                     ('store0295', '1234', '1584718920', '02-1234-5678', '010-1111-2222', 'store0295@naver.com'),
                                                                                     ('store0296', '1234', '1852872080', '02-1234-5678', '010-1111-2222', 'store0296@naver.com'),
                                                                                     ('store0297', '1234', '1429910830', '02-1234-5678', '010-1111-2222', 'store0297@naver.com'),
                                                                                     ('store0298', '1234', '0170429467', '02-1234-5678', '010-1111-2222', 'store0298@naver.com'),
                                                                                     ('store0299', '1234', '0230495657', '02-1234-5678', '010-1111-2222', 'store0299@naver.com'),
                                                                                     ('store0300', '1234', '0581169394', '02-1234-5678', '010-1111-2222', 'store0300@naver.com'),
                                                                                     ('store0301', '1234', '0527564615', '02-1234-5678', '010-1111-2222', 'store0301@naver.com'),
                                                                                     ('store0302', '1234', '0559242202', '02-1234-5678', '010-1111-2222', 'store0302@naver.com'),
                                                                                     ('store0303', '1234', '0094899292', '02-1234-5678', '010-1111-2222', 'store0303@naver.com'),
                                                                                     ('store0304', '1234', '2048401905', '02-1234-5678', '010-1111-2222', 'store0304@naver.com'),
                                                                                     ('store0305', '1234', '1824674688', '02-1234-5678', '010-1111-2222', 'store0305@naver.com'),
                                                                                     ('store0306', '1234', '1258187936', '02-1234-5678', '010-1111-2222', 'store0306@naver.com'),
                                                                                     ('store0307', '1234', '0074855381', '02-1234-5678', '010-1111-2222', 'store0307@naver.com'),
                                                                                     ('store0308', '1234', '0730082392', '02-1234-5678', '010-1111-2222', 'store0308@naver.com'),
                                                                                     ('store0309', '1234', '1533873114', '02-1234-5678', '010-1111-2222', 'store0309@naver.com'),
                                                                                     ('store0310', '1234', '1495658673', '02-1234-5678', '010-1111-2222', 'store0310@naver.com'),
                                                                                     ('store0311', '1234', '0398085524', '02-1234-5678', '010-1111-2222', 'store0311@naver.com'),
                                                                                     ('store0312', '1234', '0047645255', '02-1234-5678', '010-1111-2222', 'store0312@naver.com'),
                                                                                     ('store0313', '1234', '1229017340', '02-1234-5678', '010-1111-2222', 'store0313@naver.com'),
                                                                                     ('store0314', '1234', '1242185238', '02-1234-5678', '010-1111-2222', 'store0314@naver.com'),
                                                                                     ('store0315', '1234', '1670328538', '02-1234-5678', '010-1111-2222', 'store0315@naver.com'),
                                                                                     ('store0316', '1234', '0292294399', '02-1234-5678', '010-1111-2222', 'store0316@naver.com'),
                                                                                     ('store0317', '1234', '0753184300', '02-1234-5678', '010-1111-2222', 'store0317@naver.com'),
                                                                                     ('store0318', '1234', '0786341754', '02-1234-5678', '010-1111-2222', 'store0318@naver.com'),
                                                                                     ('store0319', '1234', '2145686392', '02-1234-5678', '010-1111-2222', 'store0319@naver.com'),
                                                                                     ('store0320', '1234', '0566322253', '02-1234-5678', '010-1111-2222', 'store0320@naver.com'),
                                                                                     ('store0321', '1234', '1357489017', '02-1234-5678', '010-1111-2222', 'store0321@naver.com'),
                                                                                     ('store0322', '1234', '1326061733', '02-1234-5678', '010-1111-2222', 'store0322@naver.com'),
                                                                                     ('store0323', '1234', '1261850050', '02-1234-5678', '010-1111-2222', 'store0323@naver.com'),
                                                                                     ('store0324', '1234', '0363009169', '02-1234-5678', '010-1111-2222', 'store0324@naver.com'),
                                                                                     ('store0325', '1234', '0207747067', '02-1234-5678', '010-1111-2222', 'store0325@naver.com'),
                                                                                     ('store0326', '1234', '1161017490', '02-1234-5678', '010-1111-2222', 'store0326@naver.com'),
                                                                                     ('store0327', '1234', '0377924515', '02-1234-5678', '010-1111-2222', 'store0327@naver.com'),
                                                                                     ('store0328', '1234', '1563288427', '02-1234-5678', '010-1111-2222', 'store0328@naver.com'),
                                                                                     ('store0329', '1234', '0578072114', '02-1234-5678', '010-1111-2222', 'store0329@naver.com'),
                                                                                     ('store0330', '1234', '0839103278', '02-1234-5678', '010-1111-2222', 'store0330@naver.com'),
                                                                                     ('store0331', '1234', '1110146250', '02-1234-5678', '010-1111-2222', 'store0331@naver.com'),
                                                                                     ('store0332', '1234', '1086592769', '02-1234-5678', '010-1111-2222', 'store0332@naver.com'),
                                                                                     ('store0333', '1234', '1339792524', '02-1234-5678', '010-1111-2222', 'store0333@naver.com'),
                                                                                     ('store0334', '1234', '0628759728', '02-1234-5678', '010-1111-2222', 'store0334@naver.com'),
                                                                                     ('store0335', '1234', '1191622146', '02-1234-5678', '010-1111-2222', 'store0335@naver.com'),
                                                                                     ('store0336', '1234', '0045208558', '02-1234-5678', '010-1111-2222', 'store0336@naver.com'),
                                                                                     ('store0337', '1234', '1881852931', '02-1234-5678', '010-1111-2222', 'store0337@naver.com'),
                                                                                     ('store0338', '1234', '1454358671', '02-1234-5678', '010-1111-2222', 'store0338@naver.com'),
                                                                                     ('store0339', '1234', '0792630688', '02-1234-5678', '010-1111-2222', 'store0339@naver.com'),
                                                                                     ('store0340', '1234', '0728436170', '02-1234-5678', '010-1111-2222', 'store0340@naver.com'),
                                                                                     ('store0341', '1234', '0092528354', '02-1234-5678', '010-1111-2222', 'store0341@naver.com'),
                                                                                     ('store0342', '1234', '0274935333', '02-1234-5678', '010-1111-2222', 'store0342@naver.com'),
                                                                                     ('store0343', '1234', '0831937813', '02-1234-5678', '010-1111-2222', 'store0343@naver.com'),
                                                                                     ('store0344', '1234', '0329496146', '02-1234-5678', '010-1111-2222', 'store0344@naver.com'),
                                                                                     ('store0345', '1234', '0637133223', '02-1234-5678', '010-1111-2222', 'store0345@naver.com'),
                                                                                     ('store0346', '1234', '2122036446', '02-1234-5678', '010-1111-2222', 'store0346@naver.com'),
                                                                                     ('store0347', '1234', '0843567523', '02-1234-5678', '010-1111-2222', 'store0347@naver.com'),
                                                                                     ('store0348', '1234', '0715355444', '02-1234-5678', '010-1111-2222', 'store0348@naver.com'),
                                                                                     ('store0349', '1234', '1049495556', '02-1234-5678', '010-1111-2222', 'store0349@naver.com'),
                                                                                     ('store0350', '1234', '1062054428', '02-1234-5678', '010-1111-2222', 'store0350@naver.com'),
                                                                                     ('store0351', '1234', '1691276845', '02-1234-5678', '010-1111-2222', 'store0351@naver.com'),
                                                                                     ('store0352', '1234', '0801165946', '02-1234-5678', '010-1111-2222', 'store0352@naver.com'),
                                                                                     ('store0353', '1234', '0980678656', '02-1234-5678', '010-1111-2222', 'store0353@naver.com'),
                                                                                     ('store0354', '1234', '0914813611', '02-1234-5678', '010-1111-2222', 'store0354@naver.com'),
                                                                                     ('store0355', '1234', '0647729190', '02-1234-5678', '010-1111-2222', 'store0355@naver.com'),
                                                                                     ('store0356', '1234', '1216634256', '02-1234-5678', '010-1111-2222', 'store0356@naver.com'),
                                                                                     ('store0357', '1234', '0777282875', '02-1234-5678', '010-1111-2222', 'store0357@naver.com'),
                                                                                     ('store0358', '1234', '0752904668', '02-1234-5678', '010-1111-2222', 'store0358@naver.com'),
                                                                                     ('store0359', '1234', '2016717228', '02-1234-5678', '010-1111-2222', 'store0359@naver.com'),
                                                                                     ('store0360', '1234', '1613953779', '02-1234-5678', '010-1111-2222', 'store0360@naver.com'),
                                                                                     ('store0361', '1234', '1286528590', '02-1234-5678', '010-1111-2222', 'store0361@naver.com'),
                                                                                     ('store0362', '1234', '0245391424', '02-1234-5678', '010-1111-2222', 'store0362@naver.com'),
                                                                                     ('store0363', '1234', '2014995117', '02-1234-5678', '010-1111-2222', 'store0363@naver.com'),
                                                                                     ('store0364', '1234', '0839328376', '02-1234-5678', '010-1111-2222', 'store0364@naver.com'),
                                                                                     ('store0365', '1234', '1181208144', '02-1234-5678', '010-1111-2222', 'store0365@naver.com'),
                                                                                     ('store0366', '1234', '1027869699', '02-1234-5678', '010-1111-2222', 'store0366@naver.com'),
                                                                                     ('store0367', '1234', '0030688071', '02-1234-5678', '010-1111-2222', 'store0367@naver.com'),
                                                                                     ('store0368', '1234', '1339258935', '02-1234-5678', '010-1111-2222', 'store0368@naver.com'),
                                                                                     ('store0369', '1234', '0387830902', '02-1234-5678', '010-1111-2222', 'store0369@naver.com'),
                                                                                     ('store0370', '1234', '0032072930', '02-1234-5678', '010-1111-2222', 'store0370@naver.com'),
                                                                                     ('store0371', '1234', '0387866926', '02-1234-5678', '010-1111-2222', 'store0371@naver.com'),
                                                                                     ('store0372', '1234', '2009451026', '02-1234-5678', '010-1111-2222', 'store0372@naver.com'),
                                                                                     ('store0373', '1234', '0540128210', '02-1234-5678', '010-1111-2222', 'store0373@naver.com'),
                                                                                     ('store0374', '1234', '1945142730', '02-1234-5678', '010-1111-2222', 'store0374@naver.com'),
                                                                                     ('store0375', '1234', '0373836358', '02-1234-5678', '010-1111-2222', 'store0375@naver.com'),
                                                                                     ('store0376', '1234', '1546132453', '02-1234-5678', '010-1111-2222', 'store0376@naver.com'),
                                                                                     ('store0377', '1234', '1235107132', '02-1234-5678', '010-1111-2222', 'store0377@naver.com'),
                                                                                     ('store0378', '1234', '0157502991', '02-1234-5678', '010-1111-2222', 'store0378@naver.com'),
                                                                                     ('store0379', '1234', '1051117137', '02-1234-5678', '010-1111-2222', 'store0379@naver.com'),
                                                                                     ('store0380', '1234', '0669912140', '02-1234-5678', '010-1111-2222', 'store0380@naver.com'),
                                                                                     ('store0381', '1234', '0284276046', '02-1234-5678', '010-1111-2222', 'store0381@naver.com'),
                                                                                     ('store0382', '1234', '1319345221', '02-1234-5678', '010-1111-2222', 'store0382@naver.com'),
                                                                                     ('store0383', '1234', '0999997890', '02-1234-5678', '010-1111-2222', 'store0383@naver.com'),
                                                                                     ('store0384', '1234', '2100788235', '02-1234-5678', '010-1111-2222', 'store0384@naver.com'),
                                                                                     ('store0385', '1234', '0185620616', '02-1234-5678', '010-1111-2222', 'store0385@naver.com'),
                                                                                     ('store0386', '1234', '0877403327', '02-1234-5678', '010-1111-2222', 'store0386@naver.com'),
                                                                                     ('store0387', '1234', '1799541680', '02-1234-5678', '010-1111-2222', 'store0387@naver.com'),
                                                                                     ('store0388', '1234', '1683358238', '02-1234-5678', '010-1111-2222', 'store0388@naver.com'),
                                                                                     ('store0389', '1234', '0889175956', '02-1234-5678', '010-1111-2222', 'store0389@naver.com'),
                                                                                     ('store0390', '1234', '1521829282', '02-1234-5678', '010-1111-2222', 'store0390@naver.com'),
                                                                                     ('store0391', '1234', '1955721446', '02-1234-5678', '010-1111-2222', 'store0391@naver.com'),
                                                                                     ('store0392', '1234', '1223775838', '02-1234-5678', '010-1111-2222', 'store0392@naver.com'),
                                                                                     ('store0393', '1234', '0888472997', '02-1234-5678', '010-1111-2222', 'store0393@naver.com'),
                                                                                     ('store0394', '1234', '1506785956', '02-1234-5678', '010-1111-2222', 'store0394@naver.com'),
                                                                                     ('store0395', '1234', '1348271639', '02-1234-5678', '010-1111-2222', 'store0395@naver.com'),
                                                                                     ('store0396', '1234', '0675249357', '02-1234-5678', '010-1111-2222', 'store0396@naver.com'),
                                                                                     ('store0397', '1234', '0324776697', '02-1234-5678', '010-1111-2222', 'store0397@naver.com'),
                                                                                     ('store0398', '1234', '0731837030', '02-1234-5678', '010-1111-2222', 'store0398@naver.com'),
                                                                                     ('store0399', '1234', '1260000047', '02-1234-5678', '010-1111-2222', 'store0399@naver.com'),
                                                                                     ('store0400', '1234', '1367874430', '02-1234-5678', '010-1111-2222', 'store0400@naver.com'),
                                                                                     ('store0401', '1234', '1370066301', '02-1234-5678', '010-1111-2222', 'store0401@naver.com'),
                                                                                     ('store0402', '1234', '0053647212', '02-1234-5678', '010-1111-2222', 'store0402@naver.com'),
                                                                                     ('store0403', '1234', '1286037956', '02-1234-5678', '010-1111-2222', 'store0403@naver.com'),
                                                                                     ('store0404', '1234', '1979122980', '02-1234-5678', '010-1111-2222', 'store0404@naver.com'),
                                                                                     ('store0405', '1234', '0850629007', '02-1234-5678', '010-1111-2222', 'store0405@naver.com'),
                                                                                     ('store0406', '1234', '2133507765', '02-1234-5678', '010-1111-2222', 'store0406@naver.com'),
                                                                                     ('store0407', '1234', '0094163115', '02-1234-5678', '010-1111-2222', 'store0407@naver.com'),
                                                                                     ('store0408', '1234', '1287168565', '02-1234-5678', '010-1111-2222', 'store0408@naver.com'),
                                                                                     ('store0409', '1234', '2147120350', '02-1234-5678', '010-1111-2222', 'store0409@naver.com'),
                                                                                     ('store0410', '1234', '0221949435', '02-1234-5678', '010-1111-2222', 'store0410@naver.com'),
                                                                                     ('store0411', '1234', '1435139752', '02-1234-5678', '010-1111-2222', 'store0411@naver.com'),
                                                                                     ('store0412', '1234', '0488342202', '02-1234-5678', '010-1111-2222', 'store0412@naver.com'),
                                                                                     ('store0413', '1234', '0355022189', '02-1234-5678', '010-1111-2222', 'store0413@naver.com'),
                                                                                     ('store0414', '1234', '0358583177', '02-1234-5678', '010-1111-2222', 'store0414@naver.com'),
                                                                                     ('store0415', '1234', '2084011581', '02-1234-5678', '010-1111-2222', 'store0415@naver.com'),
                                                                                     ('store0416', '1234', '1419575990', '02-1234-5678', '010-1111-2222', 'store0416@naver.com'),
                                                                                     ('store0417', '1234', '0484857527', '02-1234-5678', '010-1111-2222', 'store0417@naver.com'),
                                                                                     ('store0418', '1234', '0859566516', '02-1234-5678', '010-1111-2222', 'store0418@naver.com'),
                                                                                     ('store0419', '1234', '0211238051', '02-1234-5678', '010-1111-2222', 'store0419@naver.com'),
                                                                                     ('store0420', '1234', '0922454832', '02-1234-5678', '010-1111-2222', 'store0420@naver.com'),
                                                                                     ('store0421', '1234', '0272666349', '02-1234-5678', '010-1111-2222', 'store0421@naver.com'),
                                                                                     ('store0422', '1234', '0266272759', '02-1234-5678', '010-1111-2222', 'store0422@naver.com'),
                                                                                     ('store0423', '1234', '1340155351', '02-1234-5678', '010-1111-2222', 'store0423@naver.com'),
                                                                                     ('store0424', '1234', '0692558303', '02-1234-5678', '010-1111-2222', 'store0424@naver.com'),
                                                                                     ('store0425', '1234', '1988740699', '02-1234-5678', '010-1111-2222', 'store0425@naver.com'),
                                                                                     ('store0426', '1234', '1036854191', '02-1234-5678', '010-1111-2222', 'store0426@naver.com'),
                                                                                     ('store0427', '1234', '0823998411', '02-1234-5678', '010-1111-2222', 'store0427@naver.com'),
                                                                                     ('store0428', '1234', '1461016946', '02-1234-5678', '010-1111-2222', 'store0428@naver.com'),
                                                                                     ('store0429', '1234', '1518299880', '02-1234-5678', '010-1111-2222', 'store0429@naver.com'),
                                                                                     ('store0430', '1234', '0235565679', '02-1234-5678', '010-1111-2222', 'store0430@naver.com'),
                                                                                     ('store0431', '1234', '0380720829', '02-1234-5678', '010-1111-2222', 'store0431@naver.com'),
                                                                                     ('store0432', '1234', '0620967033', '02-1234-5678', '010-1111-2222', 'store0432@naver.com'),
                                                                                     ('store0433', '1234', '1364015548', '02-1234-5678', '010-1111-2222', 'store0433@naver.com'),
                                                                                     ('store0434', '1234', '1791627265', '02-1234-5678', '010-1111-2222', 'store0434@naver.com'),
                                                                                     ('store0435', '1234', '1663456421', '02-1234-5678', '010-1111-2222', 'store0435@naver.com'),
                                                                                     ('store0436', '1234', '1114008819', '02-1234-5678', '010-1111-2222', 'store0436@naver.com'),
                                                                                     ('store0437', '1234', '1885847804', '02-1234-5678', '010-1111-2222', 'store0437@naver.com'),
                                                                                     ('store0438', '1234', '0820230650', '02-1234-5678', '010-1111-2222', 'store0438@naver.com'),
                                                                                     ('store0439', '1234', '1704508872', '02-1234-5678', '010-1111-2222', 'store0439@naver.com'),
                                                                                     ('store0440', '1234', '0330654325', '02-1234-5678', '010-1111-2222', 'store0440@naver.com'),
                                                                                     ('store0441', '1234', '0848165808', '02-1234-5678', '010-1111-2222', 'store0441@naver.com'),
                                                                                     ('store0442', '1234', '1407726329', '02-1234-5678', '010-1111-2222', 'store0442@naver.com'),
                                                                                     ('store0443', '1234', '0876125290', '02-1234-5678', '010-1111-2222', 'store0443@naver.com'),
                                                                                     ('store0444', '1234', '1222103283', '02-1234-5678', '010-1111-2222', 'store0444@naver.com'),
                                                                                     ('store0445', '1234', '0513116614', '02-1234-5678', '010-1111-2222', 'store0445@naver.com'),
                                                                                     ('store0446', '1234', '0993978236', '02-1234-5678', '010-1111-2222', 'store0446@naver.com'),
                                                                                     ('store0447', '1234', '2029815200', '02-1234-5678', '010-1111-2222', 'store0447@naver.com'),
                                                                                     ('store0448', '1234', '1350562350', '02-1234-5678', '010-1111-2222', 'store0448@naver.com'),
                                                                                     ('store0449', '1234', '0840640048', '02-1234-5678', '010-1111-2222', 'store0449@naver.com'),
                                                                                     ('store0450', '1234', '0482526814', '02-1234-5678', '010-1111-2222', 'store0450@naver.com'),
                                                                                     ('store0451', '1234', '1298096451', '02-1234-5678', '010-1111-2222', 'store0451@naver.com'),
                                                                                     ('store0452', '1234', '0414452666', '02-1234-5678', '010-1111-2222', 'store0452@naver.com'),
                                                                                     ('store0453', '1234', '0250158376', '02-1234-5678', '010-1111-2222', 'store0453@naver.com'),
                                                                                     ('store0454', '1234', '0544859889', '02-1234-5678', '010-1111-2222', 'store0454@naver.com'),
                                                                                     ('store0455', '1234', '0449150721', '02-1234-5678', '010-1111-2222', 'store0455@naver.com'),
                                                                                     ('store0456', '1234', '1935578027', '02-1234-5678', '010-1111-2222', 'store0456@naver.com'),
                                                                                     ('store0457', '1234', '0100639891', '02-1234-5678', '010-1111-2222', 'store0457@naver.com'),
                                                                                     ('store0458', '1234', '0149108404', '02-1234-5678', '010-1111-2222', 'store0458@naver.com'),
                                                                                     ('store0459', '1234', '0018655885', '02-1234-5678', '010-1111-2222', 'store0459@naver.com'),
                                                                                     ('store0460', '1234', '0347321819', '02-1234-5678', '010-1111-2222', 'store0460@naver.com'),
                                                                                     ('store0461', '1234', '0717691011', '02-1234-5678', '010-1111-2222', 'store0461@naver.com'),
                                                                                     ('store0462', '1234', '0093259953', '02-1234-5678', '010-1111-2222', 'store0462@naver.com'),
                                                                                     ('store0463', '1234', '1167331575', '02-1234-5678', '010-1111-2222', 'store0463@naver.com'),
                                                                                     ('store0464', '1234', '1931322331', '02-1234-5678', '010-1111-2222', 'store0464@naver.com'),
                                                                                     ('store0465', '1234', '0305282519', '02-1234-5678', '010-1111-2222', 'store0465@naver.com'),
                                                                                     ('store0466', '1234', '1173028982', '02-1234-5678', '010-1111-2222', 'store0466@naver.com'),
                                                                                     ('store0467', '1234', '1929636118', '02-1234-5678', '010-1111-2222', 'store0467@naver.com'),
                                                                                     ('store0468', '1234', '1506654580', '02-1234-5678', '010-1111-2222', 'store0468@naver.com'),
                                                                                     ('store0469', '1234', '2090257661', '02-1234-5678', '010-1111-2222', 'store0469@naver.com'),
                                                                                     ('store0470', '1234', '2113368749', '02-1234-5678', '010-1111-2222', 'store0470@naver.com'),
                                                                                     ('store0471', '1234', '1776939297', '02-1234-5678', '010-1111-2222', 'store0471@naver.com'),
                                                                                     ('store0472', '1234', '1856446424', '02-1234-5678', '010-1111-2222', 'store0472@naver.com'),
                                                                                     ('store0473', '1234', '2145691352', '02-1234-5678', '010-1111-2222', 'store0473@naver.com'),
                                                                                     ('store0474', '1234', '0899937626', '02-1234-5678', '010-1111-2222', 'store0474@naver.com'),
                                                                                     ('store0475', '1234', '0366932829', '02-1234-5678', '010-1111-2222', 'store0475@naver.com'),
                                                                                     ('store0476', '1234', '0983054698', '02-1234-5678', '010-1111-2222', 'store0476@naver.com'),
                                                                                     ('store0477', '1234', '1992832444', '02-1234-5678', '010-1111-2222', 'store0477@naver.com'),
                                                                                     ('store0478', '1234', '0661813681', '02-1234-5678', '010-1111-2222', 'store0478@naver.com'),
                                                                                     ('store0479', '1234', '0591045617', '02-1234-5678', '010-1111-2222', 'store0479@naver.com'),
                                                                                     ('store0480', '1234', '1396883495', '02-1234-5678', '010-1111-2222', 'store0480@naver.com'),
                                                                                     ('store0481', '1234', '1045077142', '02-1234-5678', '010-1111-2222', 'store0481@naver.com'),
                                                                                     ('store0482', '1234', '1465641362', '02-1234-5678', '010-1111-2222', 'store0482@naver.com'),
                                                                                     ('store0483', '1234', '0475941333', '02-1234-5678', '010-1111-2222', 'store0483@naver.com'),
                                                                                     ('store0484', '1234', '0044507311', '02-1234-5678', '010-1111-2222', 'store0484@naver.com'),
                                                                                     ('store0485', '1234', '0650802729', '02-1234-5678', '010-1111-2222', 'store0485@naver.com'),
                                                                                     ('store0486', '1234', '0895935138', '02-1234-5678', '010-1111-2222', 'store0486@naver.com'),
                                                                                     ('store0487', '1234', '0401851625', '02-1234-5678', '010-1111-2222', 'store0487@naver.com'),
                                                                                     ('store0488', '1234', '1275476980', '02-1234-5678', '010-1111-2222', 'store0488@naver.com'),
                                                                                     ('store0489', '1234', '1355941491', '02-1234-5678', '010-1111-2222', 'store0489@naver.com'),
                                                                                     ('store0490', '1234', '0395364615', '02-1234-5678', '010-1111-2222', 'store0490@naver.com'),
                                                                                     ('store0491', '1234', '0393585442', '02-1234-5678', '010-1111-2222', 'store0491@naver.com'),
                                                                                     ('store0492', '1234', '1425365374', '02-1234-5678', '010-1111-2222', 'store0492@naver.com'),
                                                                                     ('store0493', '1234', '1585176622', '02-1234-5678', '010-1111-2222', 'store0493@naver.com'),
                                                                                     ('store0494', '1234', '2117274559', '02-1234-5678', '010-1111-2222', 'store0494@naver.com'),
                                                                                     ('store0495', '1234', '0816715487', '02-1234-5678', '010-1111-2222', 'store0495@naver.com'),
                                                                                     ('store0496', '1234', '1364374616', '02-1234-5678', '010-1111-2222', 'store0496@naver.com'),
                                                                                     ('store0497', '1234', '1961173106', '02-1234-5678', '010-1111-2222', 'store0497@naver.com'),
                                                                                     ('store0498', '1234', '1217533086', '02-1234-5678', '010-1111-2222', 'store0498@naver.com'),
                                                                                     ('store0499', '1234', '1621475417', '02-1234-5678', '010-1111-2222', 'store0499@naver.com'),
                                                                                     ('store0500', '1234', '1829088411', '02-1234-5678', '010-1111-2222', 'store0500@naver.com'),
                                                                                     ('store0501', '1234', '1186759288', '02-1234-5678', '010-1111-2222', 'store0501@naver.com'),
                                                                                     ('store0502', '1234', '0845217250', '02-1234-5678', '010-1111-2222', 'store0502@naver.com'),
                                                                                     ('store0503', '1234', '1205361721', '02-1234-5678', '010-1111-2222', 'store0503@naver.com'),
                                                                                     ('store0504', '1234', '1306281876', '02-1234-5678', '010-1111-2222', 'store0504@naver.com'),
                                                                                     ('store0505', '1234', '1936698745', '02-1234-5678', '010-1111-2222', 'store0505@naver.com'),
                                                                                     ('store0506', '1234', '1448920948', '02-1234-5678', '010-1111-2222', 'store0506@naver.com'),
                                                                                     ('store0507', '1234', '0362056004', '02-1234-5678', '010-1111-2222', 'store0507@naver.com'),
                                                                                     ('store0508', '1234', '1929922709', '02-1234-5678', '010-1111-2222', 'store0508@naver.com'),
                                                                                     ('store0509', '1234', '0434912948', '02-1234-5678', '010-1111-2222', 'store0509@naver.com'),
                                                                                     ('store0510', '1234', '0257123774', '02-1234-5678', '010-1111-2222', 'store0510@naver.com'),
                                                                                     ('store0511', '1234', '1816983345', '02-1234-5678', '010-1111-2222', 'store0511@naver.com'),
                                                                                     ('store0512', '1234', '0559467605', '02-1234-5678', '010-1111-2222', 'store0512@naver.com'),
                                                                                     ('store0513', '1234', '1619014031', '02-1234-5678', '010-1111-2222', 'store0513@naver.com'),
                                                                                     ('store0514', '1234', '1805034531', '02-1234-5678', '010-1111-2222', 'store0514@naver.com'),
                                                                                     ('store0515', '1234', '1433694364', '02-1234-5678', '010-1111-2222', 'store0515@naver.com'),
                                                                                     ('store0516', '1234', '1878126852', '02-1234-5678', '010-1111-2222', 'store0516@naver.com'),
                                                                                     ('store0517', '1234', '1966958549', '02-1234-5678', '010-1111-2222', 'store0517@naver.com'),
                                                                                     ('store0518', '1234', '0480277792', '02-1234-5678', '010-1111-2222', 'store0518@naver.com'),
                                                                                     ('store0519', '1234', '1315131923', '02-1234-5678', '010-1111-2222', 'store0519@naver.com'),
                                                                                     ('store0520', '1234', '1335014640', '02-1234-5678', '010-1111-2222', 'store0520@naver.com'),
                                                                                     ('store0521', '1234', '0494810142', '02-1234-5678', '010-1111-2222', 'store0521@naver.com'),
                                                                                     ('store0522', '1234', '0892201469', '02-1234-5678', '010-1111-2222', 'store0522@naver.com'),
                                                                                     ('store0523', '1234', '0534519884', '02-1234-5678', '010-1111-2222', 'store0523@naver.com'),
                                                                                     ('store0524', '1234', '1058133453', '02-1234-5678', '010-1111-2222', 'store0524@naver.com'),
                                                                                     ('store0525', '1234', '1139075148', '02-1234-5678', '010-1111-2222', 'store0525@naver.com'),
                                                                                     ('store0526', '1234', '1424993327', '02-1234-5678', '010-1111-2222', 'store0526@naver.com'),
                                                                                     ('store0527', '1234', '1882066809', '02-1234-5678', '010-1111-2222', 'store0527@naver.com'),
                                                                                     ('store0528', '1234', '1698503332', '02-1234-5678', '010-1111-2222', 'store0528@naver.com'),
                                                                                     ('store0529', '1234', '0680430129', '02-1234-5678', '010-1111-2222', 'store0529@naver.com'),
                                                                                     ('store0530', '1234', '1036153421', '02-1234-5678', '010-1111-2222', 'store0530@naver.com'),
                                                                                     ('store0531', '1234', '0667905460', '02-1234-5678', '010-1111-2222', 'store0531@naver.com'),
                                                                                     ('store0532', '1234', '0525537883', '02-1234-5678', '010-1111-2222', 'store0532@naver.com'),
                                                                                     ('store0533', '1234', '1062269006', '02-1234-5678', '010-1111-2222', 'store0533@naver.com'),
                                                                                     ('store0534', '1234', '0013601453', '02-1234-5678', '010-1111-2222', 'store0534@naver.com'),
                                                                                     ('store0535', '1234', '0917963413', '02-1234-5678', '010-1111-2222', 'store0535@naver.com'),
                                                                                     ('store0536', '1234', '0176550109', '02-1234-5678', '010-1111-2222', 'store0536@naver.com'),
                                                                                     ('store0537', '1234', '0501131447', '02-1234-5678', '010-1111-2222', 'store0537@naver.com'),
                                                                                     ('store0538', '1234', '2040346011', '02-1234-5678', '010-1111-2222', 'store0538@naver.com'),
                                                                                     ('store0539', '1234', '0618304995', '02-1234-5678', '010-1111-2222', 'store0539@naver.com'),
                                                                                     ('store0540', '1234', '1056363749', '02-1234-5678', '010-1111-2222', 'store0540@naver.com'),
                                                                                     ('store0541', '1234', '1538206738', '02-1234-5678', '010-1111-2222', 'store0541@naver.com'),
                                                                                     ('store0542', '1234', '0060303669', '02-1234-5678', '010-1111-2222', 'store0542@naver.com'),
                                                                                     ('store0543', '1234', '0053079911', '02-1234-5678', '010-1111-2222', 'store0543@naver.com'),
                                                                                     ('store0544', '1234', '1577279596', '02-1234-5678', '010-1111-2222', 'store0544@naver.com'),
                                                                                     ('store0545', '1234', '1303379646', '02-1234-5678', '010-1111-2222', 'store0545@naver.com'),
                                                                                     ('store0546', '1234', '0261830886', '02-1234-5678', '010-1111-2222', 'store0546@naver.com'),
                                                                                     ('store0547', '1234', '0658555356', '02-1234-5678', '010-1111-2222', 'store0547@naver.com'),
                                                                                     ('store0548', '1234', '1228156333', '02-1234-5678', '010-1111-2222', 'store0548@naver.com'),
                                                                                     ('store0549', '1234', '0942375440', '02-1234-5678', '010-1111-2222', 'store0549@naver.com'),
                                                                                     ('store0550', '1234', '1745861245', '02-1234-5678', '010-1111-2222', 'store0550@naver.com'),
                                                                                     ('store0551', '1234', '0134157058', '02-1234-5678', '010-1111-2222', 'store0551@naver.com'),
                                                                                     ('store0552', '1234', '0154749649', '02-1234-5678', '010-1111-2222', 'store0552@naver.com'),
                                                                                     ('store0553', '1234', '1813796792', '02-1234-5678', '010-1111-2222', 'store0553@naver.com'),
                                                                                     ('store0554', '1234', '0856744681', '02-1234-5678', '010-1111-2222', 'store0554@naver.com'),
                                                                                     ('store0555', '1234', '0861852370', '02-1234-5678', '010-1111-2222', 'store0555@naver.com'),
                                                                                     ('store0556', '1234', '0499811901', '02-1234-5678', '010-1111-2222', 'store0556@naver.com'),
                                                                                     ('store0557', '1234', '1315985730', '02-1234-5678', '010-1111-2222', 'store0557@naver.com'),
                                                                                     ('store0558', '1234', '0472249491', '02-1234-5678', '010-1111-2222', 'store0558@naver.com'),
                                                                                     ('store0559', '1234', '0525759435', '02-1234-5678', '010-1111-2222', 'store0559@naver.com'),
                                                                                     ('store0560', '1234', '0177468788', '02-1234-5678', '010-1111-2222', 'store0560@naver.com'),
                                                                                     ('store0561', '1234', '0632047032', '02-1234-5678', '010-1111-2222', 'store0561@naver.com'),
                                                                                     ('store0562', '1234', '2118826328', '02-1234-5678', '010-1111-2222', 'store0562@naver.com'),
                                                                                     ('store0563', '1234', '1803777643', '02-1234-5678', '010-1111-2222', 'store0563@naver.com'),
                                                                                     ('store0564', '1234', '1865662633', '02-1234-5678', '010-1111-2222', 'store0564@naver.com'),
                                                                                     ('store0565', '1234', '0621897574', '02-1234-5678', '010-1111-2222', 'store0565@naver.com'),
                                                                                     ('store0566', '1234', '0012280354', '02-1234-5678', '010-1111-2222', 'store0566@naver.com'),
                                                                                     ('store0567', '1234', '2094332345', '02-1234-5678', '010-1111-2222', 'store0567@naver.com'),
                                                                                     ('store0568', '1234', '1867832549', '02-1234-5678', '010-1111-2222', 'store0568@naver.com'),
                                                                                     ('store0569', '1234', '1308136374', '02-1234-5678', '010-1111-2222', 'store0569@naver.com'),
                                                                                     ('store0570', '1234', '0753960482', '02-1234-5678', '010-1111-2222', 'store0570@naver.com'),
                                                                                     ('store0571', '1234', '1453163263', '02-1234-5678', '010-1111-2222', 'store0571@naver.com'),
                                                                                     ('store0572', '1234', '0214105809', '02-1234-5678', '010-1111-2222', 'store0572@naver.com'),
                                                                                     ('store0573', '1234', '0883558201', '02-1234-5678', '010-1111-2222', 'store0573@naver.com'),
                                                                                     ('store0574', '1234', '1007262635', '02-1234-5678', '010-1111-2222', 'store0574@naver.com'),
                                                                                     ('store0575', '1234', '0779374230', '02-1234-5678', '010-1111-2222', 'store0575@naver.com'),
                                                                                     ('store0576', '1234', '0713994273', '02-1234-5678', '010-1111-2222', 'store0576@naver.com'),
                                                                                     ('store0577', '1234', '1806680006', '02-1234-5678', '010-1111-2222', 'store0577@naver.com'),
                                                                                     ('store0578', '1234', '1496310958', '02-1234-5678', '010-1111-2222', 'store0578@naver.com'),
                                                                                     ('store0579', '1234', '1564580825', '02-1234-5678', '010-1111-2222', 'store0579@naver.com'),
                                                                                     ('store0580', '1234', '0446501277', '02-1234-5678', '010-1111-2222', 'store0580@naver.com'),
                                                                                     ('store0581', '1234', '2140673725', '02-1234-5678', '010-1111-2222', 'store0581@naver.com'),
                                                                                     ('store0582', '1234', '0450980046', '02-1234-5678', '010-1111-2222', 'store0582@naver.com'),
                                                                                     ('store0583', '1234', '2094433851', '02-1234-5678', '010-1111-2222', 'store0583@naver.com'),
                                                                                     ('store0584', '1234', '1559065549', '02-1234-5678', '010-1111-2222', 'store0584@naver.com'),
                                                                                     ('store0585', '1234', '0393772389', '02-1234-5678', '010-1111-2222', 'store0585@naver.com'),
                                                                                     ('store0586', '1234', '1983067935', '02-1234-5678', '010-1111-2222', 'store0586@naver.com'),
                                                                                     ('store0587', '1234', '1705516405', '02-1234-5678', '010-1111-2222', 'store0587@naver.com'),
                                                                                     ('store0588', '1234', '1779929153', '02-1234-5678', '010-1111-2222', 'store0588@naver.com'),
                                                                                     ('store0589', '1234', '0274488691', '02-1234-5678', '010-1111-2222', 'store0589@naver.com'),
                                                                                     ('store0590', '1234', '1049872768', '02-1234-5678', '010-1111-2222', 'store0590@naver.com'),
                                                                                     ('store0591', '1234', '1557040855', '02-1234-5678', '010-1111-2222', 'store0591@naver.com'),
                                                                                     ('store0592', '1234', '1000852858', '02-1234-5678', '010-1111-2222', 'store0592@naver.com'),
                                                                                     ('store0593', '1234', '2034909100', '02-1234-5678', '010-1111-2222', 'store0593@naver.com'),
                                                                                     ('store0594', '1234', '0772408210', '02-1234-5678', '010-1111-2222', 'store0594@naver.com'),
                                                                                     ('store0595', '1234', '0174346688', '02-1234-5678', '010-1111-2222', 'store0595@naver.com'),
                                                                                     ('store0596', '1234', '0162240376', '02-1234-5678', '010-1111-2222', 'store0596@naver.com'),
                                                                                     ('store0597', '1234', '0717847201', '02-1234-5678', '010-1111-2222', 'store0597@naver.com'),
                                                                                     ('store0598', '1234', '1526392660', '02-1234-5678', '010-1111-2222', 'store0598@naver.com'),
                                                                                     ('store0599', '1234', '1223584041', '02-1234-5678', '010-1111-2222', 'store0599@naver.com'),
                                                                                     ('store0600', '1234', '1402369761', '02-1234-5678', '010-1111-2222', 'store0600@naver.com'),
                                                                                     ('store0601', '1234', '0703908761', '02-1234-5678', '010-1111-2222', 'store0601@naver.com'),
                                                                                     ('store0602', '1234', '0147306845', '02-1234-5678', '010-1111-2222', 'store0602@naver.com'),
                                                                                     ('store0603', '1234', '1052109915', '02-1234-5678', '010-1111-2222', 'store0603@naver.com'),
                                                                                     ('store0604', '1234', '2085171403', '02-1234-5678', '010-1111-2222', 'store0604@naver.com'),
                                                                                     ('store0605', '1234', '2018139021', '02-1234-5678', '010-1111-2222', 'store0605@naver.com'),
                                                                                     ('store0606', '1234', '1639444149', '02-1234-5678', '010-1111-2222', 'store0606@naver.com'),
                                                                                     ('store0607', '1234', '0051128513', '02-1234-5678', '010-1111-2222', 'store0607@naver.com'),
                                                                                     ('store0608', '1234', '0672061734', '02-1234-5678', '010-1111-2222', 'store0608@naver.com'),
                                                                                     ('store0609', '1234', '1555026509', '02-1234-5678', '010-1111-2222', 'store0609@naver.com'),
                                                                                     ('store0610', '1234', '1446895184', '02-1234-5678', '010-1111-2222', 'store0610@naver.com'),
                                                                                     ('store0611', '1234', '1316343512', '02-1234-5678', '010-1111-2222', 'store0611@naver.com'),
                                                                                     ('store0612', '1234', '1417175497', '02-1234-5678', '010-1111-2222', 'store0612@naver.com'),
                                                                                     ('store0613', '1234', '1470708160', '02-1234-5678', '010-1111-2222', 'store0613@naver.com'),
                                                                                     ('store0614', '1234', '0626708519', '02-1234-5678', '010-1111-2222', 'store0614@naver.com'),
                                                                                     ('store0615', '1234', '1791933506', '02-1234-5678', '010-1111-2222', 'store0615@naver.com'),
                                                                                     ('store0616', '1234', '0599642135', '02-1234-5678', '010-1111-2222', 'store0616@naver.com'),
                                                                                     ('store0617', '1234', '1990955848', '02-1234-5678', '010-1111-2222', 'store0617@naver.com'),
                                                                                     ('store0618', '1234', '0995533812', '02-1234-5678', '010-1111-2222', 'store0618@naver.com'),
                                                                                     ('store0619', '1234', '0113186042', '02-1234-5678', '010-1111-2222', 'store0619@naver.com'),
                                                                                     ('store0620', '1234', '0810869582', '02-1234-5678', '010-1111-2222', 'store0620@naver.com'),
                                                                                     ('store0621', '1234', '1021321540', '02-1234-5678', '010-1111-2222', 'store0621@naver.com'),
                                                                                     ('store0622', '1234', '1086908811', '02-1234-5678', '010-1111-2222', 'store0622@naver.com'),
                                                                                     ('store0623', '1234', '1198751139', '02-1234-5678', '010-1111-2222', 'store0623@naver.com'),
                                                                                     ('store0624', '1234', '2086638956', '02-1234-5678', '010-1111-2222', 'store0624@naver.com'),
                                                                                     ('store0625', '1234', '0549160623', '02-1234-5678', '010-1111-2222', 'store0625@naver.com'),
                                                                                     ('store0626', '1234', '2142561488', '02-1234-5678', '010-1111-2222', 'store0626@naver.com'),
                                                                                     ('store0627', '1234', '2006280441', '02-1234-5678', '010-1111-2222', 'store0627@naver.com'),
                                                                                     ('store0628', '1234', '1209106622', '02-1234-5678', '010-1111-2222', 'store0628@naver.com'),
                                                                                     ('store0629', '1234', '0899415782', '02-1234-5678', '010-1111-2222', 'store0629@naver.com'),
                                                                                     ('store0630', '1234', '1691850585', '02-1234-5678', '010-1111-2222', 'store0630@naver.com'),
                                                                                     ('store0631', '1234', '0404589160', '02-1234-5678', '010-1111-2222', 'store0631@naver.com'),
                                                                                     ('store0632', '1234', '0147969030', '02-1234-5678', '010-1111-2222', 'store0632@naver.com'),
                                                                                     ('store0633', '1234', '1767116678', '02-1234-5678', '010-1111-2222', 'store0633@naver.com'),
                                                                                     ('store0634', '1234', '1205766561', '02-1234-5678', '010-1111-2222', 'store0634@naver.com'),
                                                                                     ('store0635', '1234', '0636067771', '02-1234-5678', '010-1111-2222', 'store0635@naver.com'),
                                                                                     ('store0636', '1234', '1766858568', '02-1234-5678', '010-1111-2222', 'store0636@naver.com'),
                                                                                     ('store0637', '1234', '0859518580', '02-1234-5678', '010-1111-2222', 'store0637@naver.com'),
                                                                                     ('store0638', '1234', '0397389285', '02-1234-5678', '010-1111-2222', 'store0638@naver.com'),
                                                                                     ('store0639', '1234', '0924836845', '02-1234-5678', '010-1111-2222', 'store0639@naver.com'),
                                                                                     ('store0640', '1234', '0463266609', '02-1234-5678', '010-1111-2222', 'store0640@naver.com'),
                                                                                     ('store0641', '1234', '0993277430', '02-1234-5678', '010-1111-2222', 'store0641@naver.com'),
                                                                                     ('store0642', '1234', '1272338078', '02-1234-5678', '010-1111-2222', 'store0642@naver.com'),
                                                                                     ('store0643', '1234', '0813538588', '02-1234-5678', '010-1111-2222', 'store0643@naver.com'),
                                                                                     ('store0644', '1234', '1446735141', '02-1234-5678', '010-1111-2222', 'store0644@naver.com'),
                                                                                     ('store0645', '1234', '0724615422', '02-1234-5678', '010-1111-2222', 'store0645@naver.com'),
                                                                                     ('store0646', '1234', '1865341596', '02-1234-5678', '010-1111-2222', 'store0646@naver.com'),
                                                                                     ('store0647', '1234', '1507022747', '02-1234-5678', '010-1111-2222', 'store0647@naver.com'),
                                                                                     ('store0648', '1234', '0984689124', '02-1234-5678', '010-1111-2222', 'store0648@naver.com'),
                                                                                     ('store0649', '1234', '1060399495', '02-1234-5678', '010-1111-2222', 'store0649@naver.com'),
                                                                                     ('store0650', '1234', '1370103996', '02-1234-5678', '010-1111-2222', 'store0650@naver.com'),
                                                                                     ('store0651', '1234', '1497923622', '02-1234-5678', '010-1111-2222', 'store0651@naver.com'),
                                                                                     ('store0652', '1234', '0267335895', '02-1234-5678', '010-1111-2222', 'store0652@naver.com'),
                                                                                     ('store0653', '1234', '1926550296', '02-1234-5678', '010-1111-2222', 'store0653@naver.com'),
                                                                                     ('store0654', '1234', '1629220166', '02-1234-5678', '010-1111-2222', 'store0654@naver.com'),
                                                                                     ('store0655', '1234', '0933834545', '02-1234-5678', '010-1111-2222', 'store0655@naver.com'),
                                                                                     ('store0656', '1234', '0129346045', '02-1234-5678', '010-1111-2222', 'store0656@naver.com'),
                                                                                     ('store0657', '1234', '0903039846', '02-1234-5678', '010-1111-2222', 'store0657@naver.com'),
                                                                                     ('store0658', '1234', '1058695909', '02-1234-5678', '010-1111-2222', 'store0658@naver.com'),
                                                                                     ('store0659', '1234', '0404494169', '02-1234-5678', '010-1111-2222', 'store0659@naver.com'),
                                                                                     ('store0660', '1234', '0408711277', '02-1234-5678', '010-1111-2222', 'store0660@naver.com'),
                                                                                     ('store0661', '1234', '1942752023', '02-1234-5678', '010-1111-2222', 'store0661@naver.com'),
                                                                                     ('store0662', '1234', '1772292419', '02-1234-5678', '010-1111-2222', 'store0662@naver.com'),
                                                                                     ('store0663', '1234', '1749788924', '02-1234-5678', '010-1111-2222', 'store0663@naver.com'),
                                                                                     ('store0664', '1234', '1524937607', '02-1234-5678', '010-1111-2222', 'store0664@naver.com'),
                                                                                     ('store0665', '1234', '1866039456', '02-1234-5678', '010-1111-2222', 'store0665@naver.com'),
                                                                                     ('store0666', '1234', '1965058881', '02-1234-5678', '010-1111-2222', 'store0666@naver.com'),
                                                                                     ('store0667', '1234', '1382849764', '02-1234-5678', '010-1111-2222', 'store0667@naver.com'),
                                                                                     ('store0668', '1234', '0813025467', '02-1234-5678', '010-1111-2222', 'store0668@naver.com'),
                                                                                     ('store0669', '1234', '1917724495', '02-1234-5678', '010-1111-2222', 'store0669@naver.com'),
                                                                                     ('store0670', '1234', '0036617936', '02-1234-5678', '010-1111-2222', 'store0670@naver.com'),
                                                                                     ('store0671', '1234', '1371355166', '02-1234-5678', '010-1111-2222', 'store0671@naver.com'),
                                                                                     ('store0672', '1234', '1964228597', '02-1234-5678', '010-1111-2222', 'store0672@naver.com'),
                                                                                     ('store0673', '1234', '1183681637', '02-1234-5678', '010-1111-2222', 'store0673@naver.com'),
                                                                                     ('store0674', '1234', '1538750575', '02-1234-5678', '010-1111-2222', 'store0674@naver.com'),
                                                                                     ('store0675', '1234', '0255572713', '02-1234-5678', '010-1111-2222', 'store0675@naver.com'),
                                                                                     ('store0676', '1234', '0068291748', '02-1234-5678', '010-1111-2222', 'store0676@naver.com'),
                                                                                     ('store0677', '1234', '0515195995', '02-1234-5678', '010-1111-2222', 'store0677@naver.com'),
                                                                                     ('store0678', '1234', '0810748993', '02-1234-5678', '010-1111-2222', 'store0678@naver.com'),
                                                                                     ('store0679', '1234', '1283951818', '02-1234-5678', '010-1111-2222', 'store0679@naver.com'),
                                                                                     ('store0680', '1234', '1143174502', '02-1234-5678', '010-1111-2222', 'store0680@naver.com'),
                                                                                     ('store0681', '1234', '1737536069', '02-1234-5678', '010-1111-2222', 'store0681@naver.com'),
                                                                                     ('store0682', '1234', '0200203978', '02-1234-5678', '010-1111-2222', 'store0682@naver.com'),
                                                                                     ('store0683', '1234', '2101860284', '02-1234-5678', '010-1111-2222', 'store0683@naver.com'),
                                                                                     ('store0684', '1234', '0361829458', '02-1234-5678', '010-1111-2222', 'store0684@naver.com'),
                                                                                     ('store0685', '1234', '0266249044', '02-1234-5678', '010-1111-2222', 'store0685@naver.com'),
                                                                                     ('store0686', '1234', '1444890438', '02-1234-5678', '010-1111-2222', 'store0686@naver.com'),
                                                                                     ('store0687', '1234', '1965778053', '02-1234-5678', '010-1111-2222', 'store0687@naver.com'),
                                                                                     ('store0688', '1234', '2142556641', '02-1234-5678', '010-1111-2222', 'store0688@naver.com'),
                                                                                     ('store0689', '1234', '0731766902', '02-1234-5678', '010-1111-2222', 'store0689@naver.com'),
                                                                                     ('store0690', '1234', '1642667430', '02-1234-5678', '010-1111-2222', 'store0690@naver.com'),
                                                                                     ('store0691', '1234', '1690348068', '02-1234-5678', '010-1111-2222', 'store0691@naver.com'),
                                                                                     ('store0692', '1234', '0267412601', '02-1234-5678', '010-1111-2222', 'store0692@naver.com'),
                                                                                     ('store0693', '1234', '0201717784', '02-1234-5678', '010-1111-2222', 'store0693@naver.com'),
                                                                                     ('store0694', '1234', '1657531944', '02-1234-5678', '010-1111-2222', 'store0694@naver.com'),
                                                                                     ('store0695', '1234', '1998725735', '02-1234-5678', '010-1111-2222', 'store0695@naver.com'),
                                                                                     ('store0696', '1234', '1654685336', '02-1234-5678', '010-1111-2222', 'store0696@naver.com'),
                                                                                     ('store0697', '1234', '0088318475', '02-1234-5678', '010-1111-2222', 'store0697@naver.com'),
                                                                                     ('store0698', '1234', '1879936145', '02-1234-5678', '010-1111-2222', 'store0698@naver.com'),
                                                                                     ('store0699', '1234', '0618796441', '02-1234-5678', '010-1111-2222', 'store0699@naver.com'),
                                                                                     ('store0700', '1234', '1855747481', '02-1234-5678', '010-1111-2222', 'store0700@naver.com'),
                                                                                     ('store0701', '1234', '0837042052', '02-1234-5678', '010-1111-2222', 'store0701@naver.com'),
                                                                                     ('store0702', '1234', '0207184138', '02-1234-5678', '010-1111-2222', 'store0702@naver.com'),
                                                                                     ('store0703', '1234', '1994534743', '02-1234-5678', '010-1111-2222', 'store0703@naver.com'),
                                                                                     ('store0704', '1234', '2018331430', '02-1234-5678', '010-1111-2222', 'store0704@naver.com'),
                                                                                     ('store0705', '1234', '1070733630', '02-1234-5678', '010-1111-2222', 'store0705@naver.com'),
                                                                                     ('store0706', '1234', '1347512468', '02-1234-5678', '010-1111-2222', 'store0706@naver.com'),
                                                                                     ('store0707', '1234', '0687230596', '02-1234-5678', '010-1111-2222', 'store0707@naver.com'),
                                                                                     ('store0708', '1234', '0652976955', '02-1234-5678', '010-1111-2222', 'store0708@naver.com'),
                                                                                     ('store0709', '1234', '0603659706', '02-1234-5678', '010-1111-2222', 'store0709@naver.com'),
                                                                                     ('store0710', '1234', '1481933610', '02-1234-5678', '010-1111-2222', 'store0710@naver.com'),
                                                                                     ('store0711', '1234', '0494346834', '02-1234-5678', '010-1111-2222', 'store0711@naver.com'),
                                                                                     ('store0712', '1234', '1537396946', '02-1234-5678', '010-1111-2222', 'store0712@naver.com'),
                                                                                     ('store0713', '1234', '1247150502', '02-1234-5678', '010-1111-2222', 'store0713@naver.com'),
                                                                                     ('store0714', '1234', '0673007986', '02-1234-5678', '010-1111-2222', 'store0714@naver.com'),
                                                                                     ('store0715', '1234', '1331709569', '02-1234-5678', '010-1111-2222', 'store0715@naver.com'),
                                                                                     ('store0716', '1234', '0802145073', '02-1234-5678', '010-1111-2222', 'store0716@naver.com'),
                                                                                     ('store0717', '1234', '1276494940', '02-1234-5678', '010-1111-2222', 'store0717@naver.com'),
                                                                                     ('store0718', '1234', '1805009951', '02-1234-5678', '010-1111-2222', 'store0718@naver.com'),
                                                                                     ('store0719', '1234', '0694071461', '02-1234-5678', '010-1111-2222', 'store0719@naver.com'),
                                                                                     ('store0720', '1234', '1609907660', '02-1234-5678', '010-1111-2222', 'store0720@naver.com'),
                                                                                     ('store0721', '1234', '1536801409', '02-1234-5678', '010-1111-2222', 'store0721@naver.com'),
                                                                                     ('store0722', '1234', '1593048806', '02-1234-5678', '010-1111-2222', 'store0722@naver.com'),
                                                                                     ('store0723', '1234', '0275734687', '02-1234-5678', '010-1111-2222', 'store0723@naver.com'),
                                                                                     ('store0724', '1234', '1760257239', '02-1234-5678', '010-1111-2222', 'store0724@naver.com'),
                                                                                     ('store0725', '1234', '0623403214', '02-1234-5678', '010-1111-2222', 'store0725@naver.com'),
                                                                                     ('store0726', '1234', '1584599322', '02-1234-5678', '010-1111-2222', 'store0726@naver.com'),
                                                                                     ('store0727', '1234', '1299932718', '02-1234-5678', '010-1111-2222', 'store0727@naver.com'),
                                                                                     ('store0728', '1234', '1793542253', '02-1234-5678', '010-1111-2222', 'store0728@naver.com'),
                                                                                     ('store0729', '1234', '1994741995', '02-1234-5678', '010-1111-2222', 'store0729@naver.com'),
                                                                                     ('store0730', '1234', '0127915494', '02-1234-5678', '010-1111-2222', 'store0730@naver.com'),
                                                                                     ('store0731', '1234', '1239248286', '02-1234-5678', '010-1111-2222', 'store0731@naver.com'),
                                                                                     ('store0732', '1234', '2060957782', '02-1234-5678', '010-1111-2222', 'store0732@naver.com'),
                                                                                     ('store0733', '1234', '0903287415', '02-1234-5678', '010-1111-2222', 'store0733@naver.com'),
                                                                                     ('store0734', '1234', '0745483815', '02-1234-5678', '010-1111-2222', 'store0734@naver.com'),
                                                                                     ('store0735', '1234', '0269362590', '02-1234-5678', '010-1111-2222', 'store0735@naver.com'),
                                                                                     ('store0736', '1234', '1222593144', '02-1234-5678', '010-1111-2222', 'store0736@naver.com'),
                                                                                     ('store0737', '1234', '0928432677', '02-1234-5678', '010-1111-2222', 'store0737@naver.com'),
                                                                                     ('store0738', '1234', '1330333156', '02-1234-5678', '010-1111-2222', 'store0738@naver.com'),
                                                                                     ('store0739', '1234', '1861742639', '02-1234-5678', '010-1111-2222', 'store0739@naver.com'),
                                                                                     ('store0740', '1234', '1460149725', '02-1234-5678', '010-1111-2222', 'store0740@naver.com'),
                                                                                     ('store0741', '1234', '0101542144', '02-1234-5678', '010-1111-2222', 'store0741@naver.com'),
                                                                                     ('store0742', '1234', '1143797610', '02-1234-5678', '010-1111-2222', 'store0742@naver.com'),
                                                                                     ('store0743', '1234', '1221030073', '02-1234-5678', '010-1111-2222', 'store0743@naver.com'),
                                                                                     ('store0744', '1234', '2085389405', '02-1234-5678', '010-1111-2222', 'store0744@naver.com'),
                                                                                     ('store0745', '1234', '1238027726', '02-1234-5678', '010-1111-2222', 'store0745@naver.com'),
                                                                                     ('store0746', '1234', '1837762056', '02-1234-5678', '010-1111-2222', 'store0746@naver.com'),
                                                                                     ('store0747', '1234', '2090182968', '02-1234-5678', '010-1111-2222', 'store0747@naver.com'),
                                                                                     ('store0748', '1234', '2119720168', '02-1234-5678', '010-1111-2222', 'store0748@naver.com'),
                                                                                     ('store0749', '1234', '1580165779', '02-1234-5678', '010-1111-2222', 'store0749@naver.com'),
                                                                                     ('store0750', '1234', '1038748260', '02-1234-5678', '010-1111-2222', 'store0750@naver.com'),
                                                                                     ('store0751', '1234', '1310816403', '02-1234-5678', '010-1111-2222', 'store0751@naver.com'),
                                                                                     ('store0752', '1234', '1922664562', '02-1234-5678', '010-1111-2222', 'store0752@naver.com'),
                                                                                     ('store0753', '1234', '0594571309', '02-1234-5678', '010-1111-2222', 'store0753@naver.com'),
                                                                                     ('store0754', '1234', '0200772217', '02-1234-5678', '010-1111-2222', 'store0754@naver.com'),
                                                                                     ('store0755', '1234', '1931045901', '02-1234-5678', '010-1111-2222', 'store0755@naver.com'),
                                                                                     ('store0756', '1234', '0703759227', '02-1234-5678', '010-1111-2222', 'store0756@naver.com'),
                                                                                     ('store0757', '1234', '0109912604', '02-1234-5678', '010-1111-2222', 'store0757@naver.com'),
                                                                                     ('store0758', '1234', '1417697070', '02-1234-5678', '010-1111-2222', 'store0758@naver.com'),
                                                                                     ('store0759', '1234', '1465120212', '02-1234-5678', '010-1111-2222', 'store0759@naver.com'),
                                                                                     ('store0760', '1234', '0675860026', '02-1234-5678', '010-1111-2222', 'store0760@naver.com'),
                                                                                     ('store0761', '1234', '1295969380', '02-1234-5678', '010-1111-2222', 'store0761@naver.com'),
                                                                                     ('store0762', '1234', '1806690707', '02-1234-5678', '010-1111-2222', 'store0762@naver.com'),
                                                                                     ('store0763', '1234', '1071856311', '02-1234-5678', '010-1111-2222', 'store0763@naver.com'),
                                                                                     ('store0764', '1234', '1524198758', '02-1234-5678', '010-1111-2222', 'store0764@naver.com'),
                                                                                     ('store0765', '1234', '0165787019', '02-1234-5678', '010-1111-2222', 'store0765@naver.com'),
                                                                                     ('store0766', '1234', '1719671226', '02-1234-5678', '010-1111-2222', 'store0766@naver.com'),
                                                                                     ('store0767', '1234', '0290638069', '02-1234-5678', '010-1111-2222', 'store0767@naver.com'),
                                                                                     ('store0768', '1234', '0408448416', '02-1234-5678', '010-1111-2222', 'store0768@naver.com'),
                                                                                     ('store0769', '1234', '0178785981', '02-1234-5678', '010-1111-2222', 'store0769@naver.com'),
                                                                                     ('store0770', '1234', '0847784240', '02-1234-5678', '010-1111-2222', 'store0770@naver.com'),
                                                                                     ('store0771', '1234', '1789962800', '02-1234-5678', '010-1111-2222', 'store0771@naver.com'),
                                                                                     ('store0772', '1234', '0822408064', '02-1234-5678', '010-1111-2222', 'store0772@naver.com'),
                                                                                     ('store0773', '1234', '0768017424', '02-1234-5678', '010-1111-2222', 'store0773@naver.com'),
                                                                                     ('store0774', '1234', '0043498263', '02-1234-5678', '010-1111-2222', 'store0774@naver.com'),
                                                                                     ('store0775', '1234', '1651008129', '02-1234-5678', '010-1111-2222', 'store0775@naver.com'),
                                                                                     ('store0776', '1234', '1504313914', '02-1234-5678', '010-1111-2222', 'store0776@naver.com'),
                                                                                     ('store0777', '1234', '0872378081', '02-1234-5678', '010-1111-2222', 'store0777@naver.com'),
                                                                                     ('store0778', '1234', '1099625441', '02-1234-5678', '010-1111-2222', 'store0778@naver.com'),
                                                                                     ('store0779', '1234', '0177049253', '02-1234-5678', '010-1111-2222', 'store0779@naver.com'),
                                                                                     ('store0780', '1234', '1000129260', '02-1234-5678', '010-1111-2222', 'store0780@naver.com'),
                                                                                     ('store0781', '1234', '1747373149', '02-1234-5678', '010-1111-2222', 'store0781@naver.com'),
                                                                                     ('store0782', '1234', '1411291819', '02-1234-5678', '010-1111-2222', 'store0782@naver.com'),
                                                                                     ('store0783', '1234', '1495069524', '02-1234-5678', '010-1111-2222', 'store0783@naver.com'),
                                                                                     ('store0784', '1234', '0130791048', '02-1234-5678', '010-1111-2222', 'store0784@naver.com'),
                                                                                     ('store0785', '1234', '1395636764', '02-1234-5678', '010-1111-2222', 'store0785@naver.com'),
                                                                                     ('store0786', '1234', '1105114676', '02-1234-5678', '010-1111-2222', 'store0786@naver.com'),
                                                                                     ('store0787', '1234', '2031480754', '02-1234-5678', '010-1111-2222', 'store0787@naver.com'),
                                                                                     ('store0788', '1234', '0947838041', '02-1234-5678', '010-1111-2222', 'store0788@naver.com'),
                                                                                     ('store0789', '1234', '0282221287', '02-1234-5678', '010-1111-2222', 'store0789@naver.com'),
                                                                                     ('store0790', '1234', '0708296568', '02-1234-5678', '010-1111-2222', 'store0790@naver.com'),
                                                                                     ('store0791', '1234', '1211851999', '02-1234-5678', '010-1111-2222', 'store0791@naver.com'),
                                                                                     ('store0792', '1234', '0052393779', '02-1234-5678', '010-1111-2222', 'store0792@naver.com'),
                                                                                     ('store0793', '1234', '1802962330', '02-1234-5678', '010-1111-2222', 'store0793@naver.com'),
                                                                                     ('store0794', '1234', '0886711277', '02-1234-5678', '010-1111-2222', 'store0794@naver.com'),
                                                                                     ('store0795', '1234', '1911178409', '02-1234-5678', '010-1111-2222', 'store0795@naver.com'),
                                                                                     ('store0796', '1234', '1910422332', '02-1234-5678', '010-1111-2222', 'store0796@naver.com'),
                                                                                     ('store0797', '1234', '1787412517', '02-1234-5678', '010-1111-2222', 'store0797@naver.com'),
                                                                                     ('store0798', '1234', '1302425945', '02-1234-5678', '010-1111-2222', 'store0798@naver.com'),
                                                                                     ('store0799', '1234', '0451221857', '02-1234-5678', '010-1111-2222', 'store0799@naver.com'),
                                                                                     ('store0800', '1234', '0922570320', '02-1234-5678', '010-1111-2222', 'store0800@naver.com'),
                                                                                     ('store0801', '1234', '1392715948', '02-1234-5678', '010-1111-2222', 'store0801@naver.com'),
                                                                                     ('store0802', '1234', '1202464078', '02-1234-5678', '010-1111-2222', 'store0802@naver.com'),
                                                                                     ('store0803', '1234', '1196882123', '02-1234-5678', '010-1111-2222', 'store0803@naver.com'),
                                                                                     ('store0804', '1234', '0359277846', '02-1234-5678', '010-1111-2222', 'store0804@naver.com'),
                                                                                     ('store0805', '1234', '1591447247', '02-1234-5678', '010-1111-2222', 'store0805@naver.com'),
                                                                                     ('store0806', '1234', '1726396996', '02-1234-5678', '010-1111-2222', 'store0806@naver.com'),
                                                                                     ('store0807', '1234', '2026206254', '02-1234-5678', '010-1111-2222', 'store0807@naver.com'),
                                                                                     ('store0808', '1234', '1796073117', '02-1234-5678', '010-1111-2222', 'store0808@naver.com'),
                                                                                     ('store0809', '1234', '0661069572', '02-1234-5678', '010-1111-2222', 'store0809@naver.com'),
                                                                                     ('store0810', '1234', '1922837585', '02-1234-5678', '010-1111-2222', 'store0810@naver.com'),
                                                                                     ('store0811', '1234', '0340801420', '02-1234-5678', '010-1111-2222', 'store0811@naver.com'),
                                                                                     ('store0812', '1234', '0016818353', '02-1234-5678', '010-1111-2222', 'store0812@naver.com'),
                                                                                     ('store0813', '1234', '1818632735', '02-1234-5678', '010-1111-2222', 'store0813@naver.com'),
                                                                                     ('store0814', '1234', '1481101191', '02-1234-5678', '010-1111-2222', 'store0814@naver.com'),
                                                                                     ('store0815', '1234', '1670785516', '02-1234-5678', '010-1111-2222', 'store0815@naver.com'),
                                                                                     ('store0816', '1234', '0800732864', '02-1234-5678', '010-1111-2222', 'store0816@naver.com'),
                                                                                     ('store0817', '1234', '0738358003', '02-1234-5678', '010-1111-2222', 'store0817@naver.com'),
                                                                                     ('store0818', '1234', '0126349802', '02-1234-5678', '010-1111-2222', 'store0818@naver.com'),
                                                                                     ('store0819', '1234', '1459814611', '02-1234-5678', '010-1111-2222', 'store0819@naver.com'),
                                                                                     ('store0820', '1234', '0363500900', '02-1234-5678', '010-1111-2222', 'store0820@naver.com'),
                                                                                     ('store0821', '1234', '1327721491', '02-1234-5678', '010-1111-2222', 'store0821@naver.com'),
                                                                                     ('store0822', '1234', '0609116940', '02-1234-5678', '010-1111-2222', 'store0822@naver.com'),
                                                                                     ('store0823', '1234', '0205871313', '02-1234-5678', '010-1111-2222', 'store0823@naver.com'),
                                                                                     ('store0824', '1234', '0875385997', '02-1234-5678', '010-1111-2222', 'store0824@naver.com'),
                                                                                     ('store0825', '1234', '1267969970', '02-1234-5678', '010-1111-2222', 'store0825@naver.com'),
                                                                                     ('store0826', '1234', '1122212679', '02-1234-5678', '010-1111-2222', 'store0826@naver.com'),
                                                                                     ('store0827', '1234', '0643597623', '02-1234-5678', '010-1111-2222', 'store0827@naver.com'),
                                                                                     ('store0828', '1234', '0706548300', '02-1234-5678', '010-1111-2222', 'store0828@naver.com'),
                                                                                     ('store0829', '1234', '1451772840', '02-1234-5678', '010-1111-2222', 'store0829@naver.com'),
                                                                                     ('store0830', '1234', '1134746775', '02-1234-5678', '010-1111-2222', 'store0830@naver.com'),
                                                                                     ('store0831', '1234', '0925788390', '02-1234-5678', '010-1111-2222', 'store0831@naver.com'),
                                                                                     ('store0832', '1234', '1191538750', '02-1234-5678', '010-1111-2222', 'store0832@naver.com'),
                                                                                     ('store0833', '1234', '0072276885', '02-1234-5678', '010-1111-2222', 'store0833@naver.com'),
                                                                                     ('store0834', '1234', '0908150545', '02-1234-5678', '010-1111-2222', 'store0834@naver.com'),
                                                                                     ('store0835', '1234', '1074317890', '02-1234-5678', '010-1111-2222', 'store0835@naver.com'),
                                                                                     ('store0836', '1234', '0850869651', '02-1234-5678', '010-1111-2222', 'store0836@naver.com'),
                                                                                     ('store0837', '1234', '0761293600', '02-1234-5678', '010-1111-2222', 'store0837@naver.com'),
                                                                                     ('store0838', '1234', '0710376196', '02-1234-5678', '010-1111-2222', 'store0838@naver.com'),
                                                                                     ('store0839', '1234', '0603370566', '02-1234-5678', '010-1111-2222', 'store0839@naver.com'),
                                                                                     ('store0840', '1234', '1769011130', '02-1234-5678', '010-1111-2222', 'store0840@naver.com'),
                                                                                     ('store0841', '1234', '0938539609', '02-1234-5678', '010-1111-2222', 'store0841@naver.com'),
                                                                                     ('store0842', '1234', '2047148715', '02-1234-5678', '010-1111-2222', 'store0842@naver.com'),
                                                                                     ('store0843', '1234', '2072614578', '02-1234-5678', '010-1111-2222', 'store0843@naver.com'),
                                                                                     ('store0844', '1234', '0629566379', '02-1234-5678', '010-1111-2222', 'store0844@naver.com'),
                                                                                     ('store0845', '1234', '0191866429', '02-1234-5678', '010-1111-2222', 'store0845@naver.com'),
                                                                                     ('store0846', '1234', '0780033419', '02-1234-5678', '010-1111-2222', 'store0846@naver.com'),
                                                                                     ('store0847', '1234', '0247396191', '02-1234-5678', '010-1111-2222', 'store0847@naver.com'),
                                                                                     ('store0848', '1234', '0924115408', '02-1234-5678', '010-1111-2222', 'store0848@naver.com'),
                                                                                     ('store0849', '1234', '0795449175', '02-1234-5678', '010-1111-2222', 'store0849@naver.com'),
                                                                                     ('store0850', '1234', '0050997103', '02-1234-5678', '010-1111-2222', 'store0850@naver.com'),
                                                                                     ('store0851', '1234', '1109829298', '02-1234-5678', '010-1111-2222', 'store0851@naver.com'),
                                                                                     ('store0852', '1234', '0092135057', '02-1234-5678', '010-1111-2222', 'store0852@naver.com'),
                                                                                     ('store0853', '1234', '1627519107', '02-1234-5678', '010-1111-2222', 'store0853@naver.com'),
                                                                                     ('store0854', '1234', '0125793534', '02-1234-5678', '010-1111-2222', 'store0854@naver.com'),
                                                                                     ('store0855', '1234', '0091916591', '02-1234-5678', '010-1111-2222', 'store0855@naver.com'),
                                                                                     ('store0856', '1234', '1941512571', '02-1234-5678', '010-1111-2222', 'store0856@naver.com'),
                                                                                     ('store0857', '1234', '0466835406', '02-1234-5678', '010-1111-2222', 'store0857@naver.com'),
                                                                                     ('store0858', '1234', '0832511990', '02-1234-5678', '010-1111-2222', 'store0858@naver.com'),
                                                                                     ('store0859', '1234', '0043526181', '02-1234-5678', '010-1111-2222', 'store0859@naver.com'),
                                                                                     ('store0860', '1234', '1487875340', '02-1234-5678', '010-1111-2222', 'store0860@naver.com'),
                                                                                     ('store0861', '1234', '0145945465', '02-1234-5678', '010-1111-2222', 'store0861@naver.com'),
                                                                                     ('store0862', '1234', '0927161607', '02-1234-5678', '010-1111-2222', 'store0862@naver.com'),
                                                                                     ('store0863', '1234', '1969052551', '02-1234-5678', '010-1111-2222', 'store0863@naver.com'),
                                                                                     ('store0864', '1234', '1381515549', '02-1234-5678', '010-1111-2222', 'store0864@naver.com'),
                                                                                     ('store0865', '1234', '2090112284', '02-1234-5678', '010-1111-2222', 'store0865@naver.com'),
                                                                                     ('store0866', '1234', '1268553038', '02-1234-5678', '010-1111-2222', 'store0866@naver.com'),
                                                                                     ('store0867', '1234', '0845971163', '02-1234-5678', '010-1111-2222', 'store0867@naver.com'),
                                                                                     ('store0868', '1234', '0435180012', '02-1234-5678', '010-1111-2222', 'store0868@naver.com'),
                                                                                     ('store0869', '1234', '1809169640', '02-1234-5678', '010-1111-2222', 'store0869@naver.com'),
                                                                                     ('store0870', '1234', '1541938540', '02-1234-5678', '010-1111-2222', 'store0870@naver.com'),
                                                                                     ('store0871', '1234', '0024232779', '02-1234-5678', '010-1111-2222', 'store0871@naver.com'),
                                                                                     ('store0872', '1234', '2144282053', '02-1234-5678', '010-1111-2222', 'store0872@naver.com'),
                                                                                     ('store0873', '1234', '0346095365', '02-1234-5678', '010-1111-2222', 'store0873@naver.com'),
                                                                                     ('store0874', '1234', '1945961539', '02-1234-5678', '010-1111-2222', 'store0874@naver.com'),
                                                                                     ('store0875', '1234', '1313493209', '02-1234-5678', '010-1111-2222', 'store0875@naver.com'),
                                                                                     ('store0876', '1234', '1996251981', '02-1234-5678', '010-1111-2222', 'store0876@naver.com'),
                                                                                     ('store0877', '1234', '1241945370', '02-1234-5678', '010-1111-2222', 'store0877@naver.com'),
                                                                                     ('store0878', '1234', '0710202189', '02-1234-5678', '010-1111-2222', 'store0878@naver.com'),
                                                                                     ('store0879', '1234', '1686571184', '02-1234-5678', '010-1111-2222', 'store0879@naver.com'),
                                                                                     ('store0880', '1234', '0638188139', '02-1234-5678', '010-1111-2222', 'store0880@naver.com'),
                                                                                     ('store0881', '1234', '2130003434', '02-1234-5678', '010-1111-2222', 'store0881@naver.com'),
                                                                                     ('store0882', '1234', '1903803032', '02-1234-5678', '010-1111-2222', 'store0882@naver.com'),
                                                                                     ('store0883', '1234', '1833949845', '02-1234-5678', '010-1111-2222', 'store0883@naver.com'),
                                                                                     ('store0884', '1234', '1622929875', '02-1234-5678', '010-1111-2222', 'store0884@naver.com'),
                                                                                     ('store0885', '1234', '2089739547', '02-1234-5678', '010-1111-2222', 'store0885@naver.com'),
                                                                                     ('store0886', '1234', '0664879714', '02-1234-5678', '010-1111-2222', 'store0886@naver.com'),
                                                                                     ('store0887', '1234', '1439285116', '02-1234-5678', '010-1111-2222', 'store0887@naver.com'),
                                                                                     ('store0888', '1234', '2066432817', '02-1234-5678', '010-1111-2222', 'store0888@naver.com'),
                                                                                     ('store0889', '1234', '2089143571', '02-1234-5678', '010-1111-2222', 'store0889@naver.com'),
                                                                                     ('store0890', '1234', '0609369165', '02-1234-5678', '010-1111-2222', 'store0890@naver.com'),
                                                                                     ('store0891', '1234', '1659931447', '02-1234-5678', '010-1111-2222', 'store0891@naver.com'),
                                                                                     ('store0892', '1234', '0469897198', '02-1234-5678', '010-1111-2222', 'store0892@naver.com'),
                                                                                     ('store0893', '1234', '0442815739', '02-1234-5678', '010-1111-2222', 'store0893@naver.com'),
                                                                                     ('store0894', '1234', '0551964222', '02-1234-5678', '010-1111-2222', 'store0894@naver.com'),
                                                                                     ('store0895', '1234', '0544663370', '02-1234-5678', '010-1111-2222', 'store0895@naver.com'),
                                                                                     ('store0896', '1234', '0046799009', '02-1234-5678', '010-1111-2222', 'store0896@naver.com'),
                                                                                     ('store0897', '1234', '1140417765', '02-1234-5678', '010-1111-2222', 'store0897@naver.com'),
                                                                                     ('store0898', '1234', '1864569048', '02-1234-5678', '010-1111-2222', 'store0898@naver.com'),
                                                                                     ('store0899', '1234', '0366078169', '02-1234-5678', '010-1111-2222', 'store0899@naver.com'),
                                                                                     ('store0900', '1234', '0497746197', '02-1234-5678', '010-1111-2222', 'store0900@naver.com'),
                                                                                     ('store0901', '1234', '1370450442', '02-1234-5678', '010-1111-2222', 'store0901@naver.com'),
                                                                                     ('store0902', '1234', '1588353937', '02-1234-5678', '010-1111-2222', 'store0902@naver.com'),
                                                                                     ('store0903', '1234', '1547359170', '02-1234-5678', '010-1111-2222', 'store0903@naver.com'),
                                                                                     ('store0904', '1234', '1845791475', '02-1234-5678', '010-1111-2222', 'store0904@naver.com'),
                                                                                     ('store0905', '1234', '1839795500', '02-1234-5678', '010-1111-2222', 'store0905@naver.com'),
                                                                                     ('store0906', '1234', '0240187501', '02-1234-5678', '010-1111-2222', 'store0906@naver.com'),
                                                                                     ('store0907', '1234', '0558415048', '02-1234-5678', '010-1111-2222', 'store0907@naver.com'),
                                                                                     ('store0908', '1234', '0229216524', '02-1234-5678', '010-1111-2222', 'store0908@naver.com'),
                                                                                     ('store0909', '1234', '0534261018', '02-1234-5678', '010-1111-2222', 'store0909@naver.com'),
                                                                                     ('store0910', '1234', '0583833951', '02-1234-5678', '010-1111-2222', 'store0910@naver.com'),
                                                                                     ('store0911', '1234', '1961680100', '02-1234-5678', '010-1111-2222', 'store0911@naver.com'),
                                                                                     ('store0912', '1234', '0029568325', '02-1234-5678', '010-1111-2222', 'store0912@naver.com'),
                                                                                     ('store0913', '1234', '0209567570', '02-1234-5678', '010-1111-2222', 'store0913@naver.com'),
                                                                                     ('store0914', '1234', '1697483065', '02-1234-5678', '010-1111-2222', 'store0914@naver.com'),
                                                                                     ('store0915', '1234', '0171411392', '02-1234-5678', '010-1111-2222', 'store0915@naver.com'),
                                                                                     ('store0916', '1234', '1362105120', '02-1234-5678', '010-1111-2222', 'store0916@naver.com'),
                                                                                     ('store0917', '1234', '1230198976', '02-1234-5678', '010-1111-2222', 'store0917@naver.com'),
                                                                                     ('store0918', '1234', '0624570955', '02-1234-5678', '010-1111-2222', 'store0918@naver.com'),
                                                                                     ('store0919', '1234', '1970853694', '02-1234-5678', '010-1111-2222', 'store0919@naver.com'),
                                                                                     ('store0920', '1234', '0422234339', '02-1234-5678', '010-1111-2222', 'store0920@naver.com'),
                                                                                     ('store0921', '1234', '0509952165', '02-1234-5678', '010-1111-2222', 'store0921@naver.com'),
                                                                                     ('store0922', '1234', '0664417440', '02-1234-5678', '010-1111-2222', 'store0922@naver.com'),
                                                                                     ('store0923', '1234', '1194278450', '02-1234-5678', '010-1111-2222', 'store0923@naver.com'),
                                                                                     ('store0924', '1234', '1958873447', '02-1234-5678', '010-1111-2222', 'store0924@naver.com'),
                                                                                     ('store0925', '1234', '0241667987', '02-1234-5678', '010-1111-2222', 'store0925@naver.com'),
                                                                                     ('store0926', '1234', '2110285265', '02-1234-5678', '010-1111-2222', 'store0926@naver.com'),
                                                                                     ('store0927', '1234', '1390892081', '02-1234-5678', '010-1111-2222', 'store0927@naver.com'),
                                                                                     ('store0928', '1234', '1020868734', '02-1234-5678', '010-1111-2222', 'store0928@naver.com'),
                                                                                     ('store0929', '1234', '1027013781', '02-1234-5678', '010-1111-2222', 'store0929@naver.com'),
                                                                                     ('store0930', '1234', '2056172676', '02-1234-5678', '010-1111-2222', 'store0930@naver.com'),
                                                                                     ('store0931', '1234', '0382946433', '02-1234-5678', '010-1111-2222', 'store0931@naver.com'),
                                                                                     ('store0932', '1234', '1000043522', '02-1234-5678', '010-1111-2222', 'store0932@naver.com'),
                                                                                     ('store0933', '1234', '0442374763', '02-1234-5678', '010-1111-2222', 'store0933@naver.com'),
                                                                                     ('store0934', '1234', '0916621701', '02-1234-5678', '010-1111-2222', 'store0934@naver.com'),
                                                                                     ('store0935', '1234', '1100327471', '02-1234-5678', '010-1111-2222', 'store0935@naver.com'),
                                                                                     ('store0936', '1234', '1579838326', '02-1234-5678', '010-1111-2222', 'store0936@naver.com'),
                                                                                     ('store0937', '1234', '1526851314', '02-1234-5678', '010-1111-2222', 'store0937@naver.com'),
                                                                                     ('store0938', '1234', '0763879551', '02-1234-5678', '010-1111-2222', 'store0938@naver.com'),
                                                                                     ('store0939', '1234', '0513925952', '02-1234-5678', '010-1111-2222', 'store0939@naver.com'),
                                                                                     ('store0940', '1234', '2054867036', '02-1234-5678', '010-1111-2222', 'store0940@naver.com'),
                                                                                     ('store0941', '1234', '0245673634', '02-1234-5678', '010-1111-2222', 'store0941@naver.com'),
                                                                                     ('store0942', '1234', '0617280086', '02-1234-5678', '010-1111-2222', 'store0942@naver.com'),
                                                                                     ('store0943', '1234', '1875821823', '02-1234-5678', '010-1111-2222', 'store0943@naver.com'),
                                                                                     ('store0944', '1234', '0274895123', '02-1234-5678', '010-1111-2222', 'store0944@naver.com'),
                                                                                     ('store0945', '1234', '1524393522', '02-1234-5678', '010-1111-2222', 'store0945@naver.com'),
                                                                                     ('store0946', '1234', '0176417572', '02-1234-5678', '010-1111-2222', 'store0946@naver.com'),
                                                                                     ('store0947', '1234', '0258050933', '02-1234-5678', '010-1111-2222', 'store0947@naver.com'),
                                                                                     ('store0948', '1234', '0947556457', '02-1234-5678', '010-1111-2222', 'store0948@naver.com'),
                                                                                     ('store0949', '1234', '1401535574', '02-1234-5678', '010-1111-2222', 'store0949@naver.com'),
                                                                                     ('store0950', '1234', '0429245903', '02-1234-5678', '010-1111-2222', 'store0950@naver.com'),
                                                                                     ('store0951', '1234', '1444265463', '02-1234-5678', '010-1111-2222', 'store0951@naver.com'),
                                                                                     ('store0952', '1234', '0406481861', '02-1234-5678', '010-1111-2222', 'store0952@naver.com'),
                                                                                     ('store0953', '1234', '0024069544', '02-1234-5678', '010-1111-2222', 'store0953@naver.com'),
                                                                                     ('store0954', '1234', '1775306564', '02-1234-5678', '010-1111-2222', 'store0954@naver.com'),
                                                                                     ('store0955', '1234', '0328532697', '02-1234-5678', '010-1111-2222', 'store0955@naver.com'),
                                                                                     ('store0956', '1234', '1497870826', '02-1234-5678', '010-1111-2222', 'store0956@naver.com'),
                                                                                     ('store0957', '1234', '0073155749', '02-1234-5678', '010-1111-2222', 'store0957@naver.com'),
                                                                                     ('store0958', '1234', '0162837330', '02-1234-5678', '010-1111-2222', 'store0958@naver.com'),
                                                                                     ('store0959', '1234', '0647183425', '02-1234-5678', '010-1111-2222', 'store0959@naver.com'),
                                                                                     ('store0960', '1234', '1558891625', '02-1234-5678', '010-1111-2222', 'store0960@naver.com'),
                                                                                     ('store0961', '1234', '0110407630', '02-1234-5678', '010-1111-2222', 'store0961@naver.com'),
                                                                                     ('store0962', '1234', '0982742309', '02-1234-5678', '010-1111-2222', 'store0962@naver.com'),
                                                                                     ('store0963', '1234', '0393633814', '02-1234-5678', '010-1111-2222', 'store0963@naver.com'),
                                                                                     ('store0964', '1234', '1352752550', '02-1234-5678', '010-1111-2222', 'store0964@naver.com'),
                                                                                     ('store0965', '1234', '1557673966', '02-1234-5678', '010-1111-2222', 'store0965@naver.com'),
                                                                                     ('store0966', '1234', '1678284125', '02-1234-5678', '010-1111-2222', 'store0966@naver.com'),
                                                                                     ('store0967', '1234', '1110875414', '02-1234-5678', '010-1111-2222', 'store0967@naver.com'),
                                                                                     ('store0968', '1234', '0745813380', '02-1234-5678', '010-1111-2222', 'store0968@naver.com'),
                                                                                     ('store0969', '1234', '0058994812', '02-1234-5678', '010-1111-2222', 'store0969@naver.com'),
                                                                                     ('store0970', '1234', '0143128522', '02-1234-5678', '010-1111-2222', 'store0970@naver.com'),
                                                                                     ('store0971', '1234', '0152731399', '02-1234-5678', '010-1111-2222', 'store0971@naver.com'),
                                                                                     ('store0972', '1234', '0263169712', '02-1234-5678', '010-1111-2222', 'store0972@naver.com'),
                                                                                     ('store0973', '1234', '0032005142', '02-1234-5678', '010-1111-2222', 'store0973@naver.com'),
                                                                                     ('store0974', '1234', '0068025030', '02-1234-5678', '010-1111-2222', 'store0974@naver.com'),
                                                                                     ('store0975', '1234', '2067522565', '02-1234-5678', '010-1111-2222', 'store0975@naver.com'),
                                                                                     ('store0976', '1234', '1602201223', '02-1234-5678', '010-1111-2222', 'store0976@naver.com'),
                                                                                     ('store0977', '1234', '0254066477', '02-1234-5678', '010-1111-2222', 'store0977@naver.com'),
                                                                                     ('store0978', '1234', '0858239536', '02-1234-5678', '010-1111-2222', 'store0978@naver.com'),
                                                                                     ('store0979', '1234', '0041792762', '02-1234-5678', '010-1111-2222', 'store0979@naver.com'),
                                                                                     ('store0980', '1234', '0022921637', '02-1234-5678', '010-1111-2222', 'store0980@naver.com'),
                                                                                     ('store0981', '1234', '1474738880', '02-1234-5678', '010-1111-2222', 'store0981@naver.com'),
                                                                                     ('store0982', '1234', '1901697024', '02-1234-5678', '010-1111-2222', 'store0982@naver.com'),
                                                                                     ('store0983', '1234', '1374122796', '02-1234-5678', '010-1111-2222', 'store0983@naver.com'),
                                                                                     ('store0984', '1234', '0936742667', '02-1234-5678', '010-1111-2222', 'store0984@naver.com'),
                                                                                     ('store0985', '1234', '0339595585', '02-1234-5678', '010-1111-2222', 'store0985@naver.com'),
                                                                                     ('store0986', '1234', '0166882444', '02-1234-5678', '010-1111-2222', 'store0986@naver.com'),
                                                                                     ('store0987', '1234', '1717226737', '02-1234-5678', '010-1111-2222', 'store0987@naver.com'),
                                                                                     ('store0988', '1234', '0059042796', '02-1234-5678', '010-1111-2222', 'store0988@naver.com'),
                                                                                     ('store0989', '1234', '1420072851', '02-1234-5678', '010-1111-2222', 'store0989@naver.com'),
                                                                                     ('store0990', '1234', '2000265302', '02-1234-5678', '010-1111-2222', 'store0990@naver.com'),
                                                                                     ('store0991', '1234', '1097370493', '02-1234-5678', '010-1111-2222', 'store0991@naver.com'),
                                                                                     ('store0992', '1234', '1460136468', '02-1234-5678', '010-1111-2222', 'store0992@naver.com'),
                                                                                     ('store0993', '1234', '1264612405', '02-1234-5678', '010-1111-2222', 'store0993@naver.com'),
                                                                                     ('store0994', '1234', '1430536591', '02-1234-5678', '010-1111-2222', 'store0994@naver.com'),
                                                                                     ('store0995', '1234', '1405963228', '02-1234-5678', '010-1111-2222', 'store0995@naver.com'),
                                                                                     ('store0996', '1234', '1465187062', '02-1234-5678', '010-1111-2222', 'store0996@naver.com'),
                                                                                     ('store0997', '1234', '1537404536', '02-1234-5678', '010-1111-2222', 'store0997@naver.com'),
                                                                                     ('store0998', '1234', '0221316909', '02-1234-5678', '010-1111-2222', 'store0998@naver.com'),
                                                                                     ('store0999', '1234', '0536057083', '02-1234-5678', '010-1111-2222', 'store0999@naver.com'),
                                                                                     ('store1000', '1234', '1636598096', '02-1234-5678', '010-1111-2222', 'store1000@naver.com');
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('11', '충청북도 충주시 남산로 58 (용산동)', '금강감자탕', '금강감자탕입니다. 좋은 서비스로 모시겠습니다.', '금강감자탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:10', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('12', '강원도 정선군 남면 강원남로 5266', '돌담집', '돌담집입니다. 좋은 서비스로 모시겠습니다.', '돌담집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:11', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('13', '강원도 평창군 평창읍 약수2길 5', '송이나라', '송이나라입니다. 좋은 서비스로 모시겠습니다.', '송이나라입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:12', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('14', '경기도 하남시 덕산로 68 (덕풍동(1층))', '종로김밥(덕풍점)', '종로김밥(덕풍점)입니다. 좋은 서비스로 모시겠습니다.', '종로김밥(덕풍점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:13', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('15', '경기도 시흥시 매화로 114 (도창동)', '행복맛집', '행복맛집입니다. 좋은 서비스로 모시겠습니다.', '행복맛집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:14', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('16', '경기도 고양시 덕양구 북한산로 423 12층 (효자동)', '아덴', '아덴입니다. 좋은 서비스로 모시겠습니다.', '아덴입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:15', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('17', '경기도 안산시 단원구 만해로 127 (신길동 291-3  )', '만해통통이두루치기', '만해통통이두루치기입니다. 좋은 서비스로 모시겠습니다.', '만해통통이두루치기입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:16', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('18', '경기도 부천시 원종로 47 (원종동 1213호 3층 )', '리빈(LIVIN)', '리빈(LIVIN)입니다. 좋은 서비스로 모시겠습니다.', '리빈(LIVIN)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:17', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('19', '경기도 수원시 장안구 금당로 2 1층 (조원동 30)', '최다연샤브샤브', '최다연샤브샤브입니다. 좋은 서비스로 모시겠습니다.', '최다연샤브샤브입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:18', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('20', '울산광역시 남구 수암로40번길 22-23 (신정동)', '상황삼계탕', '상황삼계탕입니다. 좋은 서비스로 모시겠습니다.', '상황삼계탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:19', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('21', '인천광역시 남동구 인하로 497-23 지하1층 B01호 (구월동 반도프라자)', '투다리구월로데오점', '투다리구월로데오점입니다. 좋은 서비스로 모시겠습니다.', '투다리구월로데오점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:20', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('22', '인천광역시 남동구 인주대로591번길 80 1층 (구월동)', '오봉집 인천시청점', '오봉집 인천시청점입니다. 좋은 서비스로 모시겠습니다.', '오봉집 인천시청점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:21', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('23', '인천광역시 미추홀구 독정이로33번길 66 105호 (숭의동)', '푸른바다', '푸른바다입니다. 좋은 서비스로 모시겠습니다.', '푸른바다입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:22', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('24', '대구광역시 달성군 다사읍 왕선로1길 37 1층', '이거숯불치킨 다사점', '이거숯불치킨 다사점입니다. 좋은 서비스로 모시겠습니다.', '이거숯불치킨 다사점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:23', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('25', '부산광역시 부산진구 범양로125번길 12 (양정동)', '현대가든', '현대가든입니다. 좋은 서비스로 모시겠습니다.', '현대가든입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:24', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('26', '부산광역시 중구 자갈치로38번길 4 (남포동6가)', '자연산횟집2', '자연산횟집2입니다. 좋은 서비스로 모시겠습니다.', '자연산횟집2입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:25', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('27', '부산광역시 중구 보수대로44번길 9-1 (부평동4가)', '시골집', '시골집입니다. 좋은 서비스로 모시겠습니다.', '시골집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:26', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('28', '부산광역시 중구 해관로 62-1 (중앙동4가)', '말자씨식당', '말자씨식당입니다. 좋은 서비스로 모시겠습니다.', '말자씨식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:27', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('29', '서울특별시 강남구 선릉로153길 7 (신사동지하1층)', '슈진', '슈진입니다. 좋은 서비스로 모시겠습니다.', '슈진입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:28', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('30', '서울특별시 강남구 삼성로91길 24 지상1층 (삼성동)', '바다사랑', '바다사랑입니다. 좋은 서비스로 모시겠습니다.', '바다사랑입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:29', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('31', '서울특별시 종로구 지봉로7길 16 (창신동)', '창신생고기', '창신생고기입니다. 좋은 서비스로 모시겠습니다.', '창신생고기입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:30', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('32', '충청북도 청주시 청원구 내수읍 마산5길 19', '보배생삼겹살', '보배생삼겹살입니다. 좋은 서비스로 모시겠습니다.', '보배생삼겹살입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:31', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('33', '충청북도 청주시 상당구 중흥로 42 (용암동)', '놀부보쌈과 순두부', '놀부보쌈과 순두부입니다. 좋은 서비스로 모시겠습니다.', '놀부보쌈과 순두부입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:32', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('34', '경상남도 창원시 진해구 충장로 353 (경화동 지하)', '좋은날호프', '좋은날호프입니다. 좋은 서비스로 모시겠습니다.', '좋은날호프입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:33', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('35', '경상남도 창원시 의창구 동읍 의창대로915번길 8-1 (삼진A 삼진싱가102호)', '물통끌뒷고기', '물통끌뒷고기입니다. 좋은 서비스로 모시겠습니다.', '물통끌뒷고기입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:34', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('36', '경기도 화성시 비봉면 화성로 1620', '남원추어탕.종로해장국', '남원추어탕.종로해장국입니다. 좋은 서비스로 모시겠습니다.', '남원추어탕.종로해장국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:35', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('37', '경상남도 양산시 물금읍 동중7길 3', '민지네삼겹살', '민지네삼겹살입니다. 좋은 서비스로 모시겠습니다.', '민지네삼겹살입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:36', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('38', '경상남도 양산시 덕계로 52 (덕계동)', '맘스터치덕계점', '맘스터치덕계점입니다. 좋은 서비스로 모시겠습니다.', '맘스터치덕계점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:37', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('39', '경상북도 문경시 문경읍 온천1길 2', '돈벼락 선지국 문경읍점', '돈벼락 선지국 문경읍점입니다. 좋은 서비스로 모시겠습니다.', '돈벼락 선지국 문경읍점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:38', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('40', '경상북도 영주시 번영로 144 (하망동(2층))', '현주네포차', '현주네포차입니다. 좋은 서비스로 모시겠습니다.', '현주네포차입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:39', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('41', '경상북도 구미시 봉곡로 55 (봉곡동)', '돼지세끼', '돼지세끼입니다. 좋은 서비스로 모시겠습니다.', '돼지세끼입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:40', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('42', '경상북도 안동시 번영1길 11 1층 (천리동)', '용상왕갈비마트', '용상왕갈비마트입니다. 좋은 서비스로 모시겠습니다.', '용상왕갈비마트입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:41', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('43', '경상북도 경주시 탈해로52번길 43 (동천동)', '청강숯불', '청강숯불입니다. 좋은 서비스로 모시겠습니다.', '청강숯불입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:42', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('44', '전라남도 담양군 담양읍 지침6길 5', '얌샘김밥 전남담양점', '얌샘김밥 전남담양점입니다. 좋은 서비스로 모시겠습니다.', '얌샘김밥 전남담양점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:43', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('45', '전라남도 광양시 광양읍 서평10길 28', '운수좋은날', '운수좋은날입니다. 좋은 서비스로 모시겠습니다.', '운수좋은날입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:44', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('46', '전라북도 무주군 설천면 만선로 185', '돌체', '돌체입니다. 좋은 서비스로 모시겠습니다.', '돌체입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:45', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('47', '전라북도 진안군 주천면 동상주천로 2181', '운일암가든', '운일암가든입니다. 좋은 서비스로 모시겠습니다.', '운일암가든입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:46', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('48', '전라북도 김제시 요촌길 96 (요촌동)', '미화네하우스', '미화네하우스입니다. 좋은 서비스로 모시겠습니다.', '미화네하우스입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:47', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('49', '전라북도 남원시 용성로 221-8 (도통동)', '오장동 함흥면옥 숯불갈비', '오장동 함흥면옥 숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '오장동 함흥면옥 숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:48', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('50', '전라북도 익산시 중앙로7길 4 (갈산동(1층))', '운정', '운정입니다. 좋은 서비스로 모시겠습니다.', '운정입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:49', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('51', '전라북도 군산시 구암3.1로 137 (경암동)', '태양각', '태양각입니다. 좋은 서비스로 모시겠습니다.', '태양각입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:50', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('52', '전라북도 군산시 구암3.1로 137 (경암동)', '오래된미래', '오래된미래입니다. 좋은 서비스로 모시겠습니다.', '오래된미래입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:51', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('53', '전라북도 군산시 구암3.1로 137 (경암동)', '백제성', '백제성입니다. 좋은 서비스로 모시겠습니다.', '백제성입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:52', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('54', '충청남도 태안군 안면읍 안면대로 3015', '진송꽃게집', '진송꽃게집입니다. 좋은 서비스로 모시겠습니다.', '진송꽃게집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:53', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('55', '충청남도 논산시 연무읍 득안대로 645-5', '대왕가든', '대왕가든입니다. 좋은 서비스로 모시겠습니다.', '대왕가든입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:54', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('56', '충청남도 보령시 작은오랏3길 80 (동대동)', '타워', '타워입니다. 좋은 서비스로 모시겠습니다.', '타워입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:55', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('57', '충청남도 보령시 청소면 넙티로 591-22', '꿈의궁전레스토랑', '꿈의궁전레스토랑입니다. 좋은 서비스로 모시겠습니다.', '꿈의궁전레스토랑입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:56', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('58', '충청남도 공주시 우성면 내산목천길 286', '목천치킨', '목천치킨입니다. 좋은 서비스로 모시겠습니다.', '목천치킨입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:57', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('59', '충청남도 천안시 동남구 목천읍 신계1길 41', '윙윙', '윙윙입니다. 좋은 서비스로 모시겠습니다.', '윙윙입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:58', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('60', '충청북도 괴산군 장연면 연풍로 507', '남산식당', '남산식당입니다. 좋은 서비스로 모시겠습니다.', '남산식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:59', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('61', '강원도 속초시 먹거리4길 30 (교동)', '가마꿉', '가마꿉입니다. 좋은 서비스로 모시겠습니다.', '가마꿉입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:60', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('62', '강원도 강릉시 하슬라로206번길 23 (교동)', '돈비촌', '돈비촌입니다. 좋은 서비스로 모시겠습니다.', '돈비촌입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:61', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('63', '강원도 원주시 소초면 치악로 2358', '토정추어탕', '토정추어탕입니다. 좋은 서비스로 모시겠습니다.', '토정추어탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:62', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('64', '강원도 원주시 라옹정길 51-12 지상1층 (관설동)', '무쇠솥삼겹살', '무쇠솥삼겹살입니다. 좋은 서비스로 모시겠습니다.', '무쇠솥삼겹살입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:63', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('65', '경기도 연천군 전곡읍 청정로 2435', '신망리순대국', '신망리순대국입니다. 좋은 서비스로 모시겠습니다.', '신망리순대국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:64', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('66', '경기도 이천시 어재연로 22 2층 (중리동)', 'Mr.B', 'Mr.B입니다. 좋은 서비스로 모시겠습니다.', 'Mr.B입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:65', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('67', '경기도 의왕시 오매기백운산길 67 (오전동)', '도래샘', '도래샘입니다. 좋은 서비스로 모시겠습니다.', '도래샘입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:66', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('68', '경기도 구리시 이문안로136번길 20 (토평동(1층))', '꽃돼지', '꽃돼지입니다. 좋은 서비스로 모시겠습니다.', '꽃돼지입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:67', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('69', '경기도 고양시 일산서구 탄중로101번길 60 103호 (덕이동 동양라파크상가동)', '네네치킨 덕이점', '네네치킨 덕이점입니다. 좋은 서비스로 모시겠습니다.', '네네치킨 덕이점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:68', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('70', '경기도 부천시 조마루로291번길 25 (중동센타프라자 115호)', '우락', '우락입니다. 좋은 서비스로 모시겠습니다.', '우락입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:69', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('71', '경기도 부천시 부일로 506 (심곡동정우빌딩(2층))', '디스앤댓(This and That)', '디스앤댓(This and That)입니다. 좋은 서비스로 모시겠습니다.', '디스앤댓(This and That)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:70', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('72', '경기도 부천시 부일로237번길 23 (상동테마프라자 303304호)', '강원토종삼계탕Ⅱ', '강원토종삼계탕Ⅱ입니다. 좋은 서비스로 모시겠습니다.', '강원토종삼계탕Ⅱ입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:71', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('73', '울산광역시 울주군 두동면 계명3길 6', '꼴망태손칼국수', '꼴망태손칼국수입니다. 좋은 서비스로 모시겠습니다.', '꼴망태손칼국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:72', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('74', '울산광역시 동구 진성10길 38 (전하동(1층))', '깡통숯불막창', '깡통숯불막창입니다. 좋은 서비스로 모시겠습니다.', '깡통숯불막창입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:73', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('75', '울산광역시 남구 봉월로164번길 6 (신정동)', '주야주퓨전주점', '주야주퓨전주점입니다. 좋은 서비스로 모시겠습니다.', '주야주퓨전주점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:74', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('76', '대전광역시 대덕구 송촌북로 19 (중리동)', '향기정원', '향기정원입니다. 좋은 서비스로 모시겠습니다.', '향기정원입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:75', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('77', '대전광역시 유성구 엑스포로539번길 203 (탑립동)', '탑립숨두부', '탑립숨두부입니다. 좋은 서비스로 모시겠습니다.', '탑립숨두부입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:76', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('78', '대전광역시 유성구 봉산로8번길 1 (봉산동)', '참치마당', '참치마당입니다. 좋은 서비스로 모시겠습니다.', '참치마당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:77', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('79', '대전광역시 서구 배재로 88 103호 (도마동)', '교촌치킨 도마1호점', '교촌치킨 도마1호점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨 도마1호점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:78', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('80', '광주광역시 북구 하서로 542 (본촌동)', '반월추어탕 양산점', '반월추어탕 양산점입니다. 좋은 서비스로 모시겠습니다.', '반월추어탕 양산점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:79', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('81', '광주광역시 북구 면앙로6번길 78 (용봉동)', '고수닭갈비(전남대점)', '고수닭갈비(전남대점)입니다. 좋은 서비스로 모시겠습니다.', '고수닭갈비(전남대점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:80', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('82', '인천광역시 계양구 효서로 353 (작전동1층)', '신마포갈매기(까치마을점)', '신마포갈매기(까치마을점)입니다. 좋은 서비스로 모시겠습니다.', '신마포갈매기(까치마을점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:81', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('83', '인천광역시 부평구 마장로 76 (십정동)', '두리분식', '두리분식입니다. 좋은 서비스로 모시겠습니다.', '두리분식입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:82', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('84', '인천광역시 동구 동산로 76 1층 (송림동)', '코리안숯불닭바베큐', '코리안숯불닭바베큐입니다. 좋은 서비스로 모시겠습니다.', '코리안숯불닭바베큐입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:83', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('85', '인천광역시 동구 송현로11번길 5 (송현동(1층))', '대성정육식당', '대성정육식당입니다. 좋은 서비스로 모시겠습니다.', '대성정육식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:84', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('86', '대구광역시 달서구 용산로 57 (장기동(지상1층))', '회뜰날조개구이', '회뜰날조개구이입니다. 좋은 서비스로 모시겠습니다.', '회뜰날조개구이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:85', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('87', '대구광역시 달서구 월곡로 137 (상인동)', '투인라이브카페', '투인라이브카페입니다. 좋은 서비스로 모시겠습니다.', '투인라이브카페입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:86', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('88', '대구광역시 달서구 당산동2길 13 (성당동(지상1층))', '엄마코다리', '엄마코다리입니다. 좋은 서비스로 모시겠습니다.', '엄마코다리입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:87', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('89', '대구광역시 달서구 상원로 84 (상인동)', '달리고', '달리고입니다. 좋은 서비스로 모시겠습니다.', '달리고입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:88', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('90', '대구광역시 달서구 구마로10길 23 (본동(지상1층))', '길은옻닭', '길은옻닭입니다. 좋은 서비스로 모시겠습니다.', '길은옻닭입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:89', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('91', '부산광역시 사상구 사상로202번길 16 2층 (괘법동)', '샤브향사상점', '샤브향사상점입니다. 좋은 서비스로 모시겠습니다.', '샤브향사상점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:90', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('92', '부산광역시 동래구 명륜로139번길 52 (명륜동)', '동래삼선', '동래삼선입니다. 좋은 서비스로 모시겠습니다.', '동래삼선입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:91', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('93', '부산광역시 부산진구 동평로119번길 6 (부암동)', '산청본가어탕국수', '산청본가어탕국수입니다. 좋은 서비스로 모시겠습니다.', '산청본가어탕국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:92', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('94', '부산광역시 부산진구 복지로13번길 59 (개금동)', '롯데반점', '롯데반점입니다. 좋은 서비스로 모시겠습니다.', '롯데반점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:93', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('95', '서울특별시 강동구 명일로10나길 28 (둔촌동)', '먹거리마을', '먹거리마을입니다. 좋은 서비스로 모시겠습니다.', '먹거리마을입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:94', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('96', '서울특별시 서초구 서초대로77길 5 (서초동지상34층)', '888비어하우스2', '888비어하우스2입니다. 좋은 서비스로 모시겠습니다.', '888비어하우스2입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:95', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('97', '서울특별시 강서구 방화동로 19-19 (방화동)', '김포집', '김포집입니다. 좋은 서비스로 모시겠습니다.', '김포집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:96', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('98', '서울특별시 양천구 목동서로 213 (목동세신빌딩 2층)', '화사랑', '화사랑입니다. 좋은 서비스로 모시겠습니다.', '화사랑입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:97', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('99', '서울특별시 동대문구 왕산로32길 43 (용두동(용우물1길42-1))', '실내포장마차', '실내포장마차입니다. 좋은 서비스로 모시겠습니다.', '실내포장마차입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:98', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('100', '경기도 양주시 독바위로 71 2층 (덕정동)', '맘스터치', '맘스터치입니다. 좋은 서비스로 모시겠습니다.', '맘스터치입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:99', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('101', '경기도 광주시 행정타운로 125 상가동 102호 (회덕동 벽산블루밍아파트)', '잔치마을', '잔치마을입니다. 좋은 서비스로 모시겠습니다.', '잔치마을입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:100', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('102', '경상남도 김해시 대동로 14 (불암동)', '새동래장어구이', '새동래장어구이입니다. 좋은 서비스로 모시겠습니다.', '새동래장어구이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:101', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('103', '경상남도 김해시 삼안로217번길 28 (삼방동)', '고(GO)향어로', '고(GO)향어로입니다. 좋은 서비스로 모시겠습니다.', '고(GO)향어로입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:102', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('104', '강원도 홍천군 서면 한치골길 262 대명비발디파크', '시골장터', '시골장터입니다. 좋은 서비스로 모시겠습니다.', '시골장터입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:103', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('105', '경기도 김포시 풍무로69번길 17 (풍무동)', '풍무동428번지', '풍무동428번지입니다. 좋은 서비스로 모시겠습니다.', '풍무동428번지입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:104', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('106', '광주광역시 북구 저불로 18-4 (용봉동)', '옹고집보쌈', '옹고집보쌈입니다. 좋은 서비스로 모시겠습니다.', '옹고집보쌈입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:105', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('107', '광주광역시 북구 일곡택지로 71 1층 (일곡동)', '뜨락', '뜨락입니다. 좋은 서비스로 모시겠습니다.', '뜨락입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:106', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('108', '광주광역시 북구 우치로383번길 8 (삼각동)', '뚱뚱이할머니', '뚱뚱이할머니입니다. 좋은 서비스로 모시겠습니다.', '뚱뚱이할머니입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:107', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('109', '인천광역시 계양구 주부토로514번길 4 (계산동1층)', '솔잎정육식당', '솔잎정육식당입니다. 좋은 서비스로 모시겠습니다.', '솔잎정육식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:108', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('110', '인천광역시 부평구 주부토로 114 (부평동)', '참이맛감자탕 부평구청점', '참이맛감자탕 부평구청점입니다. 좋은 서비스로 모시겠습니다.', '참이맛감자탕 부평구청점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:109', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('111', '인천광역시 부평구 세월천로 3 (청천동)', '좋은세상', '좋은세상입니다. 좋은 서비스로 모시겠습니다.', '좋은세상입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:110', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('112', '인천광역시 부평구 경원대로1403번길 20-4 (부평동)', '야끼토리 코미오', '야끼토리 코미오입니다. 좋은 서비스로 모시겠습니다.', '야끼토리 코미오입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:111', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('113', '대구광역시 달서구 성서공단로11길 72 (호산동(지상1층))', '정원한우갈비', '정원한우갈비입니다. 좋은 서비스로 모시겠습니다.', '정원한우갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:112', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('114', '서울특별시 강동구 올림픽로 816 (암사동)', '투다리', '투다리입니다. 좋은 서비스로 모시겠습니다.', '투다리입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:113', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('115', '서울특별시 서초구 바우뫼로 190 (양재동하남빌딩1층101호)', '뚜또오케이', '뚜또오케이입니다. 좋은 서비스로 모시겠습니다.', '뚜또오케이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:114', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('116', '충청북도 청주시 청원구 공항로150번길 135 (율량동 1층)', '나만의밥상', '나만의밥상입니다. 좋은 서비스로 모시겠습니다.', '나만의밥상입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:115', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('117', '경상남도 창원시 성산구 월림로65번길 10 (신촌동1층)', '청화관', '청화관입니다. 좋은 서비스로 모시겠습니다.', '청화관입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:116', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('118', '경기도 광주시 곤지암읍 곤지암로50번길 20', '비어스쿨', '비어스쿨입니다. 좋은 서비스로 모시겠습니다.', '비어스쿨입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:117', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('119', '경상남도 거창군 거창읍 거열로6길 56-3', '순살이양념치킨', '순살이양념치킨입니다. 좋은 서비스로 모시겠습니다.', '순살이양념치킨입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:118', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('120', '경상남도 고성군 고성읍 중앙로25번길 58 다1동 108-2호 (고성시장상가)', '은하식당', '은하식당입니다. 좋은 서비스로 모시겠습니다.', '은하식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:119', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('121', '경상남도 함안군 가야읍 가야4길 8 ((1층))', '포식정', '포식정입니다. 좋은 서비스로 모시겠습니다.', '포식정입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:120', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('122', '경상남도 밀양시 중앙로 146 (가곡동)', '충남식당', '충남식당입니다. 좋은 서비스로 모시겠습니다.', '충남식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:121', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('123', '경상남도 김해시 함박로45번길 4-16 (외동)', '송화정', '송화정입니다. 좋은 서비스로 모시겠습니다.', '송화정입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:122', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('124', '경상남도 진주시 북장대로81번길 11 (상봉동지상1층일부)', '처갓집양념치킨(상봉점)', '처갓집양념치킨(상봉점)입니다. 좋은 서비스로 모시겠습니다.', '처갓집양념치킨(상봉점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:123', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('125', '경상북도 경산시 성암로 79 (옥산동)', '꽃돼지보쌈족발', '꽃돼지보쌈족발입니다. 좋은 서비스로 모시겠습니다.', '꽃돼지보쌈족발입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:124', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('126', '경상북도 구미시 구미중앙로35길 20 (원평동)', '까뮤', '까뮤입니다. 좋은 서비스로 모시겠습니다.', '까뮤입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:125', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('127', '경상북도 안동시 광명로 6 (옥동)', '하임', '하임입니다. 좋은 서비스로 모시겠습니다.', '하임입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:126', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('128', '경상북도 포항시 남구 호미곶면 해맞이로150번길 11-1 B동', '호미곶 왕짜장', '호미곶 왕짜장입니다. 좋은 서비스로 모시겠습니다.', '호미곶 왕짜장입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:127', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('129', '전라남도 담양군 고서면 가사문학로 324-6', '동하당', '동하당입니다. 좋은 서비스로 모시겠습니다.', '동하당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:128', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('130', '전라남도 나주시 산포면 산남로 67-37', '옛맛드림', '옛맛드림입니다. 좋은 서비스로 모시겠습니다.', '옛맛드림입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:129', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('131', '전라남도 순천시 하대석길 75 1층 (연향동)', '에스이씨.(sec.)', '에스이씨.(sec.)입니다. 좋은 서비스로 모시겠습니다.', '에스이씨.(sec.)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:130', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('132', '전라남도 순천시 남신월1길 14 (조례동지상(1층))', '시로', '시로입니다. 좋은 서비스로 모시겠습니다.', '시로입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:131', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('133', '전라남도 순천시 왕궁길 22 (조례동(1층))', '박씨네숯불갈비', '박씨네숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '박씨네숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:132', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('134', '전라남도 목포시 백년대로375번길 11 (옥암동)', '정도리', '정도리입니다. 좋은 서비스로 모시겠습니다.', '정도리입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:133', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('135', '전라남도 목포시 상동로 41 105호 (상동 주공2단지상가동)', '아라치목포상동점', '아라치목포상동점입니다. 좋은 서비스로 모시겠습니다.', '아라치목포상동점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:134', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('136', '전라북도 남원시 옥정4길 11-2 (향교동)', '우소보소', '우소보소입니다. 좋은 서비스로 모시겠습니다.', '우소보소입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:135', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('137', '전라북도 전주시 완산구 고사평6길 3-3 (서신동)', '이즈', '이즈입니다. 좋은 서비스로 모시겠습니다.', '이즈입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:136', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('138', '충청남도 예산군 삽교읍 수암산로 211', '수암산다슬기백숙전문점', '수암산다슬기백숙전문점입니다. 좋은 서비스로 모시겠습니다.', '수암산다슬기백숙전문점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:137', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('139', '충청남도 예산군 예산읍 천변로145번길 7', '딜리버리쿡(예산점)', '딜리버리쿡(예산점)입니다. 좋은 서비스로 모시겠습니다.', '딜리버리쿡(예산점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:138', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('140', '충청남도 서산시 한마음13로 9 (석림동)', '최가네 바베큐', '최가네 바베큐입니다. 좋은 서비스로 모시겠습니다.', '최가네 바베큐입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:139', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('141', '충청남도 천안시 서북구 백석3로 70 103호 (백석동)', '교촌치킨백석점', '교촌치킨백석점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨백석점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:140', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('142', '충청북도 음성군 대소면 대화1길 3', '태흥칡냉면', '태흥칡냉면입니다. 좋은 서비스로 모시겠습니다.', '태흥칡냉면입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:141', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('143', '충청북도 영동군 황간면 황간동로 28', '동화식육식당', '동화식육식당입니다. 좋은 서비스로 모시겠습니다.', '동화식육식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:142', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('144', '충청북도 제천시 수산면 옥순봉로 1248 이에스리조트클럽', '고개마루', '고개마루입니다. 좋은 서비스로 모시겠습니다.', '고개마루입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:143', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('145', '강원도 태백시 동태백로 823 (백산동)', '박대정', '박대정입니다. 좋은 서비스로 모시겠습니다.', '박대정입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:144', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('146', '강원도 강릉시 율곡초교길43번길 9 (교동)', '마쮸램', '마쮸램입니다. 좋은 서비스로 모시겠습니다.', '마쮸램입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:145', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('147', '강원도 원주시 남원로527번길 82-15 (명륜동)', '굴렁쇠', '굴렁쇠입니다. 좋은 서비스로 모시겠습니다.', '굴렁쇠입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:146', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('148', '강원도 원주시 문막읍 왕건로 75 2층', '검은고양이', '검은고양이입니다. 좋은 서비스로 모시겠습니다.', '검은고양이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:147', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('149', '경기도 용인시 기흥구 신구로 50 (구갈동)', '김밥&고기비비고쓱싹비빔밥', '김밥&고기비비고쓱싹비빔밥입니다. 좋은 서비스로 모시겠습니다.', '김밥&고기비비고쓱싹비빔밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:148', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('150', '경기도 시흥시 도일로 127 (거모동1층 (47블럭 2롯트))', '허박사', '허박사입니다. 좋은 서비스로 모시겠습니다.', '허박사입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:149', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('151', '경기도 시흥시 신현로38번길 16 1층 (포동)', '왕십리 곱창볶음', '왕십리 곱창볶음입니다. 좋은 서비스로 모시겠습니다.', '왕십리 곱창볶음입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:150', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('152', '경기도 고양시 일산서구 탄현로6번길 23-13 1(전체)층 (탄현동)', '신세계', '신세계입니다. 좋은 서비스로 모시겠습니다.', '신세계입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:151', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('153', '경기도 평택시 경기대로 635 (세교동)', '짬뽕파크24시', '짬뽕파크24시입니다. 좋은 서비스로 모시겠습니다.', '짬뽕파크24시입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:152', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('154', '경기도 평택시 팽성읍 부용로31번길 5', '뼈다귀천하', '뼈다귀천하입니다. 좋은 서비스로 모시겠습니다.', '뼈다귀천하입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:153', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('155', '경기도 부천시 상이로39번길 30-7 (상동)', '쪼끼쪼끼', '쪼끼쪼끼입니다. 좋은 서비스로 모시겠습니다.', '쪼끼쪼끼입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:154', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('156', '경기도 부천시 조마루로85번길 11 (상동)', '별빛', '별빛입니다. 좋은 서비스로 모시겠습니다.', '별빛입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:155', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('157', '경기도 성남시 수정구 수정로111번길 6-13 (태평동1층)', '함경도식당', '함경도식당입니다. 좋은 서비스로 모시겠습니다.', '함경도식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:156', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('158', '경기도 성남시 분당구 돌마로 75 (금곡동 미금프라자 1층109호)', '쇼란', '쇼란입니다. 좋은 서비스로 모시겠습니다.', '쇼란입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:157', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('159', '경기도 성남시 분당구 구미로 60 (구미동관보쇼핑 지하1층35호)', '명동 왕족발보쌈', '명동 왕족발보쌈입니다. 좋은 서비스로 모시겠습니다.', '명동 왕족발보쌈입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:158', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('160', '울산광역시 울주군 온산읍 산암로 33 ((1층))', '신라해장국', '신라해장국입니다. 좋은 서비스로 모시겠습니다.', '신라해장국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:159', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('161', '울산광역시 동구 문현로 102 (방어동)', '토속삼계탕', '토속삼계탕입니다. 좋은 서비스로 모시겠습니다.', '토속삼계탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:160', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('162', '대전광역시 서구 둔산로73번길 37 1층 (둔산동)', '초콜릿', '초콜릿입니다. 좋은 서비스로 모시겠습니다.', '초콜릿입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:161', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('163', '대전광역시 서구 둔산로73번길 37 (둔산동)', '웰빙주먹구이', '웰빙주먹구이입니다. 좋은 서비스로 모시겠습니다.', '웰빙주먹구이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:162', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('164', '대전광역시 서구 둔산로73번길 37 (둔산동)', '영동올갱이', '영동올갱이입니다. 좋은 서비스로 모시겠습니다.', '영동올갱이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:163', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('165', '광주광역시 동구 필문대로205번길 12 (지산동(1층))', '계화', '계화입니다. 좋은 서비스로 모시겠습니다.', '계화입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:164', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('166', '인천광역시 옹진군 영흥면 영흥남로9번길 179-21', '성난파도', '성난파도입니다. 좋은 서비스로 모시겠습니다.', '성난파도입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:165', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('167', '인천광역시 강화군 강화읍 중앙로 43 (터미널126호)', '황가네호떡', '황가네호떡입니다. 좋은 서비스로 모시겠습니다.', '황가네호떡입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:166', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('168', '인천광역시 부평구 세월천로 34 208~210호 (청천동 대우프라자)', '육곳간', '육곳간입니다. 좋은 서비스로 모시겠습니다.', '육곳간입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:167', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('169', '인천광역시 부평구 마장로 489 (청천동아이즈빌아울렛2132호)', '상상김밥', '상상김밥입니다. 좋은 서비스로 모시겠습니다.', '상상김밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:168', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('170', '인천광역시 부평구 세월천로 34 (청천동대우프라자207호)', '굴세상', '굴세상입니다. 좋은 서비스로 모시겠습니다.', '굴세상입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:169', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('171', '인천광역시 미추홀구 소성로 238 (학익동)', '열린음악회', '열린음악회입니다. 좋은 서비스로 모시겠습니다.', '열린음악회입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:170', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('172', '인천광역시 미추홀구 독배로462번길 55 (숭의동)', '김밥나라', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:171', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('173', '인천광역시 동구 화도진로 9-1 1층 (금곡동)', '옵서예', '옵서예입니다. 좋은 서비스로 모시겠습니다.', '옵서예입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:172', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('174', '인천광역시 동구 화도진로 182-3 (만석동(2층))', '영남생고기전문점', '영남생고기전문점입니다. 좋은 서비스로 모시겠습니다.', '영남생고기전문점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:173', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('175', '대구광역시 달서구 와룡로 92 1층 (본리동)', '전주팔미콩나물국밥', '전주팔미콩나물국밥입니다. 좋은 서비스로 모시겠습니다.', '전주팔미콩나물국밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:174', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('176', '대구광역시 달서구 학산로 243 (송현동(1층))', '시골국수집', '시골국수집입니다. 좋은 서비스로 모시겠습니다.', '시골국수집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:175', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('177', '대구광역시 북구 검단로 8-5 (복현동)', '동해복어', '동해복어입니다. 좋은 서비스로 모시겠습니다.', '동해복어입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:176', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('178', '부산광역시 사상구 광장로81번길 35 (괘법동)', '생고기제작소 사상점', '생고기제작소 사상점입니다. 좋은 서비스로 모시겠습니다.', '생고기제작소 사상점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:177', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('179', '부산광역시 해운대구 좌동로 115 (좌동 지상1층 일부)', '제일 칼국수', '제일 칼국수입니다. 좋은 서비스로 모시겠습니다.', '제일 칼국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:178', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('180', '부산광역시 해운대구 신반송로 102 (반송동 삼한2차212-105호)', '이대감돼지국밥', '이대감돼지국밥입니다. 좋은 서비스로 모시겠습니다.', '이대감돼지국밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:179', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('181', '부산광역시 남구 신선로 313-1 (용당동)', '에비타', '에비타입니다. 좋은 서비스로 모시겠습니다.', '에비타입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:180', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('182', '부산광역시 동래구 충렬대로255번길 20 (낙민동)', '하나축산', '하나축산입니다. 좋은 서비스로 모시겠습니다.', '하나축산입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:181', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('183', '부산광역시 동래구 명륜로139번길 52 (명륜동)', '가지마루', '가지마루입니다. 좋은 서비스로 모시겠습니다.', '가지마루입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:182', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('184', '부산광역시 부산진구 서면로68번길 35 지상2층 (부전동)', '하연정순두부', '하연정순두부입니다. 좋은 서비스로 모시겠습니다.', '하연정순두부입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:183', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('185', '부산광역시 중구 구덕로48번길 4-1 (남포동2가)', '럭스', '럭스입니다. 좋은 서비스로 모시겠습니다.', '럭스입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:184', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('186', '서울특별시 송파구 오금로46길 31 지상1층 (가락동)', '갈비명가', '갈비명가입니다. 좋은 서비스로 모시겠습니다.', '갈비명가입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:185', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('187', '서울특별시 동작구 동작대로17길 6 (사당동)', '놀란돼지(이수점)', '놀란돼지(이수점)입니다. 좋은 서비스로 모시겠습니다.', '놀란돼지(이수점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:186', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('188', '서울특별시 성북구 동소문로44길 6 (하월곡동)', '목포식당', '목포식당입니다. 좋은 서비스로 모시겠습니다.', '목포식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:187', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('189', '서울특별시 종로구 인사동14길 43 (관훈동)', '떡상', '떡상입니다. 좋은 서비스로 모시겠습니다.', '떡상입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:188', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('190', '경상남도 창원시 성산구 단정로 14 쌍둥이빌딩 1층 102호 (상남동)', '제주돈도리', '제주돈도리입니다. 좋은 서비스로 모시겠습니다.', '제주돈도리입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:189', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('191', '경상남도 창원시 마산회원구 내서읍 삼계본동1길 37-1', '달맞이숯불갈비', '달맞이숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '달맞이숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:190', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('192', '경기도 포천시 신북면 심곡리 679-4번지 ', '고향오리집', '고향오리집입니다. 좋은 서비스로 모시겠습니다.', '고향오리집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:191', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('193', '경상남도 거창군 가조면 가조가야로 1110-14', '시장분식', '시장분식입니다. 좋은 서비스로 모시겠습니다.', '시장분식입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:192', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('194', '경상남도 산청군 시천면 삼신봉로 665-14', '세석농원', '세석농원입니다. 좋은 서비스로 모시겠습니다.', '세석농원입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:193', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('195', '경상남도 의령군 부림면 신번로10길 25', '오일반점', '오일반점입니다. 좋은 서비스로 모시겠습니다.', '오일반점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:194', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('196', '경상남도 김해시 능동로155번길 10-15 308호 (부곡동 새미래네오피아)', '풍경민속레스토랑', '풍경민속레스토랑입니다. 좋은 서비스로 모시겠습니다.', '풍경민속레스토랑입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:195', TRUE, FALSE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('197', '경상북도 군위군 부계면 한티로 2111', '황솔식당', '황솔식당입니다. 좋은 서비스로 모시겠습니다.', '황솔식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:196', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('198', '경상북도 포항시 남구 오천읍 해병로259번길 34 (외2필지(309-95.309-101))', '하이트프라임', '하이트프라임입니다. 좋은 서비스로 모시겠습니다.', '하이트프라임입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:197', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('199', '경상북도 포항시 북구 죽도로40번길 8 (죽도동(12층))', '신라왕갈비', '신라왕갈비입니다. 좋은 서비스로 모시겠습니다.', '신라왕갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:198', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('200', '전라남도 광양시 담안길 77-4 (태인동(1층))', '우리식당', '우리식당입니다. 좋은 서비스로 모시겠습니다.', '우리식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:199', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('201', '전라남도 광양시 용지길 16 (태인동)', '목장촌', '목장촌입니다. 좋은 서비스로 모시겠습니다.', '목장촌입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:200', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('202', '전라북도 부안군 부안읍 석정로 316 (외 1필지)', '콩사랑손두부고을', '콩사랑손두부고을입니다. 좋은 서비스로 모시겠습니다.', '콩사랑손두부고을입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:201', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('203', '전라북도 장수군 번암면 방화동로 633', '장수마루', '장수마루입니다. 좋은 서비스로 모시겠습니다.', '장수마루입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:202', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('204', '전라북도 무주군 설천면 만선로 185', '스키바 9', '스키바 9입니다. 좋은 서비스로 모시겠습니다.', '스키바 9입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:203', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('205', '전라북도 무주군 설천면 만선로 185', '설천 패스트 푸드', '설천 패스트 푸드입니다. 좋은 서비스로 모시겠습니다.', '설천 패스트 푸드입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:204', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('206', '전라북도 전주시 덕진구 정언신로 157 (우아동2가외1필지)', '카페루앤비아중점', '카페루앤비아중점입니다. 좋은 서비스로 모시겠습니다.', '카페루앤비아중점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:205', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('207', '충청남도 홍성군 서부면 이호길 39', '서부야식', '서부야식입니다. 좋은 서비스로 모시겠습니다.', '서부야식입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:206', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('208', '충청남도 논산시 중앙로492번길 9-10 (화지동)', '가야곡식당', '가야곡식당입니다. 좋은 서비스로 모시겠습니다.', '가야곡식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:207', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('209', '충청남도 아산시 배방읍 호서로79번길 15', '한솥도시락체인점', '한솥도시락체인점입니다. 좋은 서비스로 모시겠습니다.', '한솥도시락체인점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:208', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('210', '충청남도 공주시 탄천면 통산3길 6', '신고향식당', '신고향식당입니다. 좋은 서비스로 모시겠습니다.', '신고향식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:209', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('211', '충청남도 천안시 서북구 나사렛대길 14-7 1층 (쌍용동)', '탕화쿵푸마라탕', '탕화쿵푸마라탕입니다. 좋은 서비스로 모시겠습니다.', '탕화쿵푸마라탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:210', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('212', '충청남도 천안시 서북구 서부대로 766 (두정동)', '김밥나라천안8호점', '김밥나라천안8호점입니다. 좋은 서비스로 모시겠습니다.', '김밥나라천안8호점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:211', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('213', '강원도 속초시 영금정로 7-4 (동명동)', '항구식당', '항구식당입니다. 좋은 서비스로 모시겠습니다.', '항구식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:212', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('214', '강원도 강릉시 경강로2245번길 28 (포남동)', '해촌해물삼계탕', '해촌해물삼계탕입니다. 좋은 서비스로 모시겠습니다.', '해촌해물삼계탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:213', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('215', '경기도 파주시 탄현면 한산로 6-46', '통일촌장단콩마을', '통일촌장단콩마을입니다. 좋은 서비스로 모시겠습니다.', '통일촌장단콩마을입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:214', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('216', '경기도 시흥시 은행로173번길 7 (대야동 이수(빌)121호)', '정가네식당', '정가네식당입니다. 좋은 서비스로 모시겠습니다.', '정가네식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:215', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('217', '경기도 시흥시 군자로 514 101102호 (거모동)', '고만당', '고만당입니다. 좋은 서비스로 모시겠습니다.', '고만당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:216', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('218', '경기도 안산시 단원구 와동공원로 126 (와동 769-27  1층)', '펀비어킹', '펀비어킹입니다. 좋은 서비스로 모시겠습니다.', '펀비어킹입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:217', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('219', '경기도 광명시 금하로 534-7 1층 (소하동)', '일미', '일미입니다. 좋은 서비스로 모시겠습니다.', '일미입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:218', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('220', '경기도 부천시 중동로254번길 104 (중동호정프라자 206호)', '묵향', '묵향입니다. 좋은 서비스로 모시겠습니다.', '묵향입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:219', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('221', '경기도 안양시 동안구 시민대로365번길 39 (관양동 지상1층)', '전주한식뷔페', '전주한식뷔페입니다. 좋은 서비스로 모시겠습니다.', '전주한식뷔페입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:220', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('222', '울산광역시 남구 월평로37번길 4 (신정동(지상1층))', '밀양칼국수', '밀양칼국수입니다. 좋은 서비스로 모시겠습니다.', '밀양칼국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:221', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('223', '대전광역시 서구 계백로1286번길 18 (정림동)', '짜장왕', '짜장왕입니다. 좋은 서비스로 모시겠습니다.', '짜장왕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:222', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('224', '광주광역시 서구 화개중앙로3번길 5 2층 (금호동)', '나능이능이버섯백숙(금호점)', '나능이능이버섯백숙(금호점)입니다. 좋은 서비스로 모시겠습니다.', '나능이능이버섯백숙(금호점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:223', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('225', '인천광역시 계양구 계산새로 1 1동 3층 303호 (계산동)', '원조 장충동왕족발', '원조 장충동왕족발입니다. 좋은 서비스로 모시겠습니다.', '원조 장충동왕족발입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:224', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('226', '인천광역시 남동구 문화로245번길 38-1 (간석동)', '장원', '장원입니다. 좋은 서비스로 모시겠습니다.', '장원입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:225', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('227', '대구광역시 달서구 야외음악당로 193 (두류동)', '지리산흑돼지', '지리산흑돼지입니다. 좋은 서비스로 모시겠습니다.', '지리산흑돼지입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:226', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('228', '대구광역시 달서구 성서서로 365 (신당동(지상1층))', '삼미', '삼미입니다. 좋은 서비스로 모시겠습니다.', '삼미입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:227', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('229', '대구광역시 북구 노원동로6길 4 (노원동2가)', '영양식당', '영양식당입니다. 좋은 서비스로 모시겠습니다.', '영양식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:228', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('230', '대구광역시 북구 대학로13길 17 (산격동)', '목아지삼촌고깃집', '목아지삼촌고깃집입니다. 좋은 서비스로 모시겠습니다.', '목아지삼촌고깃집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:229', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('231', '대구광역시 중구 동성로2길 31 (삼덕동1가)', '토모루스시', '토모루스시입니다. 좋은 서비스로 모시겠습니다.', '토모루스시입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:230', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('232', '부산광역시 북구 백양대로 1007 (구포동)', '김밥나라', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:231', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('233', '서울특별시 영등포구 당산로38길 16 (당산동4가1층)', '송백식당', '송백식당입니다. 좋은 서비스로 모시겠습니다.', '송백식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:232', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('234', '서울특별시 구로구 경인로 398 (고척동)', '송림가', '송림가입니다. 좋은 서비스로 모시겠습니다.', '송림가입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:233', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('235', '서울특별시 중랑구 망우로66길 63 (망우동)', '풍년집', '풍년집입니다. 좋은 서비스로 모시겠습니다.', '풍년집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:234', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('236', '서울특별시 동대문구 답십리로51길 35 1층 (답십리동)', '네네치킨', '네네치킨입니다. 좋은 서비스로 모시겠습니다.', '네네치킨입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:235', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('237', '충청북도 청주시 상당구 영운천로153번길 36 (금천동)', '즐거운나의집돌솥밥', '즐거운나의집돌솥밥입니다. 좋은 서비스로 모시겠습니다.', '즐거운나의집돌솥밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:236', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('238', '충청북도 청주시 상당구 1순환로1514번길 40 (용정동)', '영양마을', '영양마을입니다. 좋은 서비스로 모시겠습니다.', '영양마을입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:237', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('239', '충청북도 청주시 상당구 문의면 문의시내로 32', '수아분식', '수아분식입니다. 좋은 서비스로 모시겠습니다.', '수아분식입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:238', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('240', '충청북도 청주시 청원구 2순환로 364 201동 202호 (사천동공구상가)', '다정식당', '다정식당입니다. 좋은 서비스로 모시겠습니다.', '다정식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:239', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('241', '경상남도 창원시 마산회원구 내서읍 삼계본동2길 13-4 (570번지)', '정자나무집', '정자나무집입니다. 좋은 서비스로 모시겠습니다.', '정자나무집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:240', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('242', '경상남도 창원시 의창구 남산로17번길 33-1 1층 (팔용동)', '전주식당', '전주식당입니다. 좋은 서비스로 모시겠습니다.', '전주식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:241', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('243', '경기도 포천시 이동면 금강로6263번길 229', '여올가든', '여올가든입니다. 좋은 서비스로 모시겠습니다.', '여올가든입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:242', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('244', '경기도 광주시 곤지암읍 곤지암로 88-21', '청실홍실', '청실홍실입니다. 좋은 서비스로 모시겠습니다.', '청실홍실입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:243', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('245', '경상남도 창녕군 남지읍 남지시장길 16', '대풍해장국', '대풍해장국입니다. 좋은 서비스로 모시겠습니다.', '대풍해장국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:244', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('246', '경상남도 거제시 거제중앙로13길 2 (고현동(1층))', '약속카페', '약속카페입니다. 좋은 서비스로 모시겠습니다.', '약속카페입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:245', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('247', '경상남도 진주시 진주대로960번길 11-1 (칠암동1층일부)', '마루축산식육식당', '마루축산식육식당입니다. 좋은 서비스로 모시겠습니다.', '마루축산식육식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:246', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('248', '경상남도 진주시 진주성로 94 (상봉동지상1층)', '까투리', '까투리입니다. 좋은 서비스로 모시겠습니다.', '까투리입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:247', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('249', '경상북도 칠곡군 왜관읍 공단로 53', '청학동한식당', '청학동한식당입니다. 좋은 서비스로 모시겠습니다.', '청학동한식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:248', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('250', '경상북도 칠곡군 왜관읍 공단로 50', '순대전문점금강산', '순대전문점금강산입니다. 좋은 서비스로 모시겠습니다.', '순대전문점금강산입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:249', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('251', '경상북도 경산시 성암로12길 2 (옥산동)', '영희네밥상', '영희네밥상입니다. 좋은 서비스로 모시겠습니다.', '영희네밥상입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:250', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('252', '경상북도 구미시 금오산로 140 1층 (원평동)', '신사랑방식당', '신사랑방식당입니다. 좋은 서비스로 모시겠습니다.', '신사랑방식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:251', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('253', '경상북도 구미시 산호대로25길 29-1 (옥계동)', '김태주선산곱창옥계점', '김태주선산곱창옥계점입니다. 좋은 서비스로 모시겠습니다.', '김태주선산곱창옥계점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:252', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('254', '경상북도 포항시 북구 새천년대로1259번길 6-18 1층 (장성동)', '신돈값하는 국밥집', '신돈값하는 국밥집입니다. 좋은 서비스로 모시겠습니다.', '신돈값하는 국밥집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:253', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('255', '전라남도 보성군 보성읍 신흥길 25', '청정횟집', '청정횟집입니다. 좋은 서비스로 모시겠습니다.', '청정횟집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:254', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('256', '전라남도 광양시 아미1길 4 (중동 1층중1층전부)', '전주왱오콩나물해장국', '전주왱오콩나물해장국입니다. 좋은 서비스로 모시겠습니다.', '전주왱오콩나물해장국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:255', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('257', '전라남도 광양시 광장1길 11 (중동)', '덮다 광양중동점', '덮다 광양중동점입니다. 좋은 서비스로 모시겠습니다.', '덮다 광양중동점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:256', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('258', '전라남도 광양시 공영로 100 3층중2층일부 (중동)', 'W-Bar (더블유바)', 'W-Bar (더블유바)입니다. 좋은 서비스로 모시겠습니다.', 'W-Bar (더블유바)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:257', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('259', '전라남도 순천시 율산공원길 73 (연향동34 (34층))', '콜럼버스', '콜럼버스입니다. 좋은 서비스로 모시겠습니다.', '콜럼버스입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:258', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('260', '전라남도 여수시 돌산읍 향일암로 69', '언덕마루', '언덕마루입니다. 좋은 서비스로 모시겠습니다.', '언덕마루입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:259', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('261', '전라남도 목포시 백년대로375번길 23 (옥암동)', '금호고깃집', '금호고깃집입니다. 좋은 서비스로 모시겠습니다.', '금호고깃집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:260', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('262', '전라북도 임실군 오수면 오수5길 5', '오수추어탕', '오수추어탕입니다. 좋은 서비스로 모시겠습니다.', '오수추어탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:261', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('263', '전라북도 김제시 검산택지길 19 1층 (검산동)', '두가촌', '두가촌입니다. 좋은 서비스로 모시겠습니다.', '두가촌입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:262', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('264', '전라북도 익산시 익산대로58길 32 (신동(1층))', '1989', '1989입니다. 좋은 서비스로 모시겠습니다.', '1989입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:263', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('265', '전라북도 전주시 덕진구 아중로 212 (우아동1가)', '놀부보쌈부대찌개아중점', '놀부보쌈부대찌개아중점입니다. 좋은 서비스로 모시겠습니다.', '놀부보쌈부대찌개아중점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:264', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('266', '충청남도 부여군 부여읍 사비로 97 2층', '닉스레스토랑', '닉스레스토랑입니다. 좋은 서비스로 모시겠습니다.', '닉스레스토랑입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:265', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('267', '충청북도 옥천군 옥천읍 중앙로5길 5', '호동 갈비', '호동 갈비입니다. 좋은 서비스로 모시겠습니다.', '호동 갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:266', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('268', '강원도 태백시 해지개길 17-3 (황지동)', '한꼬지 돈구이', '한꼬지 돈구이입니다. 좋은 서비스로 모시겠습니다.', '한꼬지 돈구이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:267', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('269', '강원도 태백시 장성로 36 (장성동)', '닭갈비나라', '닭갈비나라입니다. 좋은 서비스로 모시겠습니다.', '닭갈비나라입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:268', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('270', '경기도 이천시 마장면 청강가창로 421', '은지이모', '은지이모입니다. 좋은 서비스로 모시겠습니다.', '은지이모입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:269', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('271', '경기도 남양주시 별내면 청학로 115 (1213)', '풍타죽토속음식점', '풍타죽토속음식점입니다. 좋은 서비스로 모시겠습니다.', '풍타죽토속음식점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:270', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('272', '경기도 남양주시 진접읍 팔야로 280', '대중 일티하우스', '대중 일티하우스입니다. 좋은 서비스로 모시겠습니다.', '대중 일티하우스입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:271', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('273', '경기도 고양시 일산동구 견달산로 351 (문봉동번지외2필지 1층)', '야구장농원', '야구장농원입니다. 좋은 서비스로 모시겠습니다.', '야구장농원입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:272', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('274', '경기도 안산시 단원구 원곡로 23 (원곡동 797-1  1층)', '오뚜기수타면', '오뚜기수타면입니다. 좋은 서비스로 모시겠습니다.', '오뚜기수타면입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:273', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('275', '경기도 광명시 범안로 1042 (하안동제일빌팅 113 112호)', '삼합홍어회전문', '삼합홍어회전문입니다. 좋은 서비스로 모시겠습니다.', '삼합홍어회전문입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:274', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('276', '경기도 성남시 중원구 순환로 467 1층 (은행동)', '오대오 바지락칼국수', '오대오 바지락칼국수입니다. 좋은 서비스로 모시겠습니다.', '오대오 바지락칼국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:275', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('277', '경기도 수원시 팔달구 팔달로 105 3층 (화서동)', '선화네한식뷔페', '선화네한식뷔페입니다. 좋은 서비스로 모시겠습니다.', '선화네한식뷔페입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:276', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('278', '경기도 수원시 팔달구 일월로22번길 22-5 107호 (화서동 서수원프라자)', '메차쿠차', '메차쿠차입니다. 좋은 서비스로 모시겠습니다.', '메차쿠차입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:277', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('279', '경기도 수원시 팔달구 중부대로206번길 4 (인계동)', '1인자감자탕', '1인자감자탕입니다. 좋은 서비스로 모시겠습니다.', '1인자감자탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:278', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('280', '울산광역시 동구 옥류로 12 (동부동)', '폭풍장어', '폭풍장어입니다. 좋은 서비스로 모시겠습니다.', '폭풍장어입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:279', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('281', '울산광역시 남구 도산로101번길 6 (달동)', '가미', '가미입니다. 좋은 서비스로 모시겠습니다.', '가미입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:280', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('282', '광주광역시 광산구 첨단중앙로152번길 31-3 (쌍암동)', '와바(첨단점)', '와바(첨단점)입니다. 좋은 서비스로 모시겠습니다.', '와바(첨단점)입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:281', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('283', '인천광역시 옹진군 대청면 대청남로86번길 87', '정원가든', '정원가든입니다. 좋은 서비스로 모시겠습니다.', '정원가든입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:282', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('284', '인천광역시 강화군 강화읍 강화대로 399', '청춘포차', '청춘포차입니다. 좋은 서비스로 모시겠습니다.', '청춘포차입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:283', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('285', '인천광역시 강화군 교동면 대룡안길29번길 6', '고향식당', '고향식당입니다. 좋은 서비스로 모시겠습니다.', '고향식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:284', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('286', '대구광역시 달성군 현풍읍 현풍중앙로 8', '진국명국', '진국명국입니다. 좋은 서비스로 모시겠습니다.', '진국명국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:285', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('287', '대구광역시 달성군 다사읍 달구벌대로 750', '꽃잔디식당', '꽃잔디식당입니다. 좋은 서비스로 모시겠습니다.', '꽃잔디식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:286', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('288', '대구광역시 달서구 월배로 66 AB동 1층 (진천동)', '방가로', '방가로입니다. 좋은 서비스로 모시겠습니다.', '방가로입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:287', TRUE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('289', '부산광역시 수영구 수영성로3번길 7 1층 (수영동)', '장수삼', '장수삼입니다. 좋은 서비스로 모시겠습니다.', '장수삼입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:288', TRUE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('290', '부산광역시 중구 광복로 40 2-3층 (창선동2가)', '라화쿵부 부산남포점', '라화쿵부 부산남포점입니다. 좋은 서비스로 모시겠습니다.', '라화쿵부 부산남포점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:289', TRUE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('291', '서울특별시 강남구 개포로22길 31 (개포동지상1층)', '아미고', '아미고입니다. 좋은 서비스로 모시겠습니다.', '아미고입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:290', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('292', '서울특별시 강남구 테헤란로39길 57 (역삼동지상1층)', '라비', '라비입니다. 좋은 서비스로 모시겠습니다.', '라비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:291', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('293', '서울특별시 강남구 언주로114길 5 (논현동지상1층)', '돈먹고 돈내고', '돈먹고 돈내고입니다. 좋은 서비스로 모시겠습니다.', '돈먹고 돈내고입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:292', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('294', '서울특별시 서초구 바우뫼로33길 7-12 지상 1층 (양재동)', '조선커피', '조선커피입니다. 좋은 서비스로 모시겠습니다.', '조선커피입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:293', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('295', '서울특별시 강서구 강서로56가길 53 지하 1층 (등촌동 3동)', '희미한 옛사랑의 그림자', '희미한 옛사랑의 그림자입니다. 좋은 서비스로 모시겠습니다.', '희미한 옛사랑의 그림자입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:294', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('296', '서울특별시 강서구 공항대로 635 (염창동)', '김가네김밥', '김가네김밥입니다. 좋은 서비스로 모시겠습니다.', '김가네김밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:295', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('297', '서울특별시 강서구 양천로 87 1층 (방화동 1동)', '교촌치킨 방화1호점', '교촌치킨 방화1호점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨 방화1호점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:296', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('298', '서울특별시 노원구 상계로5길 31 보광빌딩 3층 (상계동)', '이찌방이야기', '이찌방이야기입니다. 좋은 서비스로 모시겠습니다.', '이찌방이야기입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:297', TRUE, TRUE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('299', '서울특별시 도봉구 덕릉로54길 7 (창동(1층))', '서용미곱창', '서용미곱창입니다. 좋은 서비스로 모시겠습니다.', '서용미곱창입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:298', TRUE, TRUE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('300', '서울특별시 성북구 솔샘로1길 10 (정릉동101)', '김밥고을', '김밥고을입니다. 좋은 서비스로 모시겠습니다.', '김밥고을입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:299', TRUE, TRUE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('301', '서울특별시 동대문구 한천로 142 (장안동(한천로 142))', '바지락칼국수', '바지락칼국수입니다. 좋은 서비스로 모시겠습니다.', '바지락칼국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:300', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('302', '서울특별시 광진구 아차산로31길 9-1 1층 (화양동)', '평화김해뒷고기', '평화김해뒷고기입니다. 좋은 서비스로 모시겠습니다.', '평화김해뒷고기입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:301', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('303', '서울특별시 광진구 아차산로33길 26 지하1층 (화양동)', '만만요리연구소', '만만요리연구소입니다. 좋은 서비스로 모시겠습니다.', '만만요리연구소입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:302', TRUE, TRUE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('304', '서울특별시 성동구 광나루로 287 지상1층 (송정동)', '싸리골', '싸리골입니다. 좋은 서비스로 모시겠습니다.', '싸리골입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:303', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('305', '서울특별시 용산구 새창로49길 19 (신계동(1층))', '160도', '160도입니다. 좋은 서비스로 모시겠습니다.', '160도입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:304', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('306', '서울특별시 중구 청파로 457-1 (중림동(1층))', '해원각', '해원각입니다. 좋은 서비스로 모시겠습니다.', '해원각입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:305', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('307', '제주특별자치도 제주시 정존5길 7 (노형동)', '맛나감자탕제주1호점', '맛나감자탕제주1호점입니다. 좋은 서비스로 모시겠습니다.', '맛나감자탕제주1호점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:306', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('308', '충청북도 청주시 상당구 남일면 단재로 730-1', '흥부네즉석김밥', '흥부네즉석김밥입니다. 좋은 서비스로 모시겠습니다.', '흥부네즉석김밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:307', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('309', '경상남도 창원시 마산회원구 합성옛길 19 (양덕동)', '외가집곰탕', '외가집곰탕입니다. 좋은 서비스로 모시겠습니다.', '외가집곰탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:308', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('310', '경상남도 창원시 성산구 마디미로44번길 7 2층 201호 (상남동 상남빌딩)', '백스비어상남점', '백스비어상남점입니다. 좋은 서비스로 모시겠습니다.', '백스비어상남점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:309', TRUE, TRUE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('311', '경기도 포천시 영북면 산정호수로 171', '가는골', '가는골입니다. 좋은 서비스로 모시겠습니다.', '가는골입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:310', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('312', '충청남도 계룡시 엄사면 연화동길 27', '연화식당', '연화식당입니다. 좋은 서비스로 모시겠습니다.', '연화식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:311', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('313', '경상남도 산청군 신안면 원지로 5 1층', '동해왕갈비', '동해왕갈비입니다. 좋은 서비스로 모시겠습니다.', '동해왕갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:312', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('314', '경상남도 의령군 의령읍 의병로 236-1', '무끼피자', '무끼피자입니다. 좋은 서비스로 모시겠습니다.', '무끼피자입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:313', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('315', '경상남도 양산시 양주1길 18 (중부동(1층))', '한우참숯구이전문점', '한우참숯구이전문점입니다. 좋은 서비스로 모시겠습니다.', '한우참숯구이전문점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:314', TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('316', '경상남도 양산시 외산길 35 (덕계동)', '심봤다순한방갈비', '심봤다순한방갈비입니다. 좋은 서비스로 모시겠습니다.', '심봤다순한방갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:315', TRUE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('317', '경상남도 거제시 중곡로 51 (고현동중곡빌딩201호)', '이화원', '이화원입니다. 좋은 서비스로 모시겠습니다.', '이화원입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:316', TRUE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('318', '경상남도 김해시 장유로416번길 43', '족묵자', '족묵자입니다. 좋은 서비스로 모시겠습니다.', '족묵자입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:317', TRUE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('319', '경상남도 진주시 신평공원길69번길 6-1 (평거동1층)', '차담', '차담입니다. 좋은 서비스로 모시겠습니다.', '차담입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:318', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('320', '경상남도 진주시 진주대로 1160 (봉곡동지상2층일부)', '뜰안에', '뜰안에입니다. 좋은 서비스로 모시겠습니다.', '뜰안에입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:319', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('321', '경상북도 영덕군 영덕읍 우곡길 37', '돼지막구이', '돼지막구이입니다. 좋은 서비스로 모시겠습니다.', '돼지막구이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:320', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('322', '경상북도 청송군 파천면 청송로 5529', '엄마손맛사랑', '엄마손맛사랑입니다. 좋은 서비스로 모시겠습니다.', '엄마손맛사랑입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:321', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('323', '경상북도 영주시 구성로178번길 6 (휴천동)', '소머리국밥', '소머리국밥입니다. 좋은 서비스로 모시겠습니다.', '소머리국밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:322', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('324', '경상북도 구미시 천생산길 70 1층 (구평동)', '토산보신원', '토산보신원입니다. 좋은 서비스로 모시겠습니다.', '토산보신원입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:323', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('325', '경상북도 구미시 원남로 42-2 1층 (원평동)', '뜨끈이감자탕', '뜨끈이감자탕입니다. 좋은 서비스로 모시겠습니다.', '뜨끈이감자탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:324', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('326', '경상북도 구미시 신시로7길 12-5 상가동 1층 108호 (형곡동)', '노군꼬치', '노군꼬치입니다. 좋은 서비스로 모시겠습니다.', '노군꼬치입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:325', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('327', '경상북도 경주시 양정로 220 (동천동)', '한라도니', '한라도니입니다. 좋은 서비스로 모시겠습니다.', '한라도니입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:326', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('328', '전라남도 광양시 광양읍 대림오성로 107 (1층중1층일부)', '우노 오성점', '우노 오성점입니다. 좋은 서비스로 모시겠습니다.', '우노 오성점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:327', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('329', '전라남도 순천시 해룡면 동명초등길 16 ((1층))', '청보석', '청보석입니다. 좋은 서비스로 모시겠습니다.', '청보석입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:328', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('330', '전라남도 순천시 연향3로 4-1 (연향동(지하))', '조롱박', '조롱박입니다. 좋은 서비스로 모시겠습니다.', '조롱박입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:329', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('331', '전라남도 순천시 왕궁중앙길 6 (조례동(1층))', '보고또보고', '보고또보고입니다. 좋은 서비스로 모시겠습니다.', '보고또보고입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:330', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('332', '전라북도 완주군 봉동읍 원둔산4길 12', '돈마니', '돈마니입니다. 좋은 서비스로 모시겠습니다.', '돈마니입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:331', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('333', '충청남도 금산군 금산읍 향군길 22', '쌍둥이네삼겹살', '쌍둥이네삼겹살입니다. 좋은 서비스로 모시겠습니다.', '쌍둥이네삼겹살입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:332', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('334', '충청남도 보령시 해수욕장5길 9 (신흑동)', '영동횟집', '영동횟집입니다. 좋은 서비스로 모시겠습니다.', '영동횟집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:333', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('335', '충청남도 천안시 서북구 차돌들길 10 (쌍용동)', '가야산뼈해장국', '가야산뼈해장국입니다. 좋은 서비스로 모시겠습니다.', '가야산뼈해장국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:334', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('336', '충청북도 단양군 단양읍 삼봉로 299', '김밥천국 단양도시락', '김밥천국 단양도시락입니다. 좋은 서비스로 모시겠습니다.', '김밥천국 단양도시락입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:335', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('337', '충청북도 괴산군 문광면 괴산로 2596', '가족농원식당', '가족농원식당입니다. 좋은 서비스로 모시겠습니다.', '가족농원식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:336', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('338', '충청북도 제천시 하소로 68 (하소동)', '교촌치킨명동점', '교촌치킨명동점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨명동점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:337', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('339', '강원도 강릉시 곶감전길 15 (성남동)', '양철통', '양철통입니다. 좋은 서비스로 모시겠습니다.', '양철통입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:338', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('340', '강원도 강릉시 성덕포남로182번길 42 (포남동)', '고향마을', '고향마을입니다. 좋은 서비스로 모시겠습니다.', '고향마을입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:339', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('341', '강원도 춘천시 동내면 거두단지길 6-8', '거두리청국장', '거두리청국장입니다. 좋은 서비스로 모시겠습니다.', '거두리청국장입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:340', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('342', '경기도 의왕시 백운로 394 (학의동)', '와우리장작구이 백운호수점', '와우리장작구이 백운호수점입니다. 좋은 서비스로 모시겠습니다.', '와우리장작구이 백운호수점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:341', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('343', '경기도 고양시 일산동구 강송로 115 107호 (백석동 중앙상가)', '교촌치킨백송점', '교촌치킨백송점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨백송점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:342', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('344', '경기도 부천시 소향로 35 (상동월드프라자 104호)', '부송국수집', '부송국수집입니다. 좋은 서비스로 모시겠습니다.', '부송국수집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:343', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('345', '경기도 부천시 석천로 397 (삼정동 부천테크노파크쌍용3차 첨단제조3층 203동301호)', '강촌삼계탕', '강촌삼계탕입니다. 좋은 서비스로 모시겠습니다.', '강촌삼계탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:344', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('346', '경기도 성남시 수정구 산성대로 213 1층 (신흥동)', '옛날감자탕 수진점', '옛날감자탕 수진점입니다. 좋은 서비스로 모시겠습니다.', '옛날감자탕 수진점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:345', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('347', '경기도 성남시 분당구 황새울로258번길 42 (수내동)', '그 집', '그 집입니다. 좋은 서비스로 모시겠습니다.', '그 집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:346', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('348', '경기도 수원시 권선구 권선로536번길 11 1층 (세류동)', '청안한방오리', '청안한방오리입니다. 좋은 서비스로 모시겠습니다.', '청안한방오리입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:347', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('349', '경기도 수원시 장안구 경수대로973번길 13-3 (송죽동)', '영미식당', '영미식당입니다. 좋은 서비스로 모시겠습니다.', '영미식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:348', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('350', '경기도 수원시 권선구 권중로56번길 2 (권선동)', '꽃피는 닭갈비', '꽃피는 닭갈비입니다. 좋은 서비스로 모시겠습니다.', '꽃피는 닭갈비입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:349', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('351', '울산광역시 울주군 온산읍 내동3길 16-4 (외1필지 2동(1층))', '한밭식당', '한밭식당입니다. 좋은 서비스로 모시겠습니다.', '한밭식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:350', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('352', '울산광역시 울주군 온산읍 신온9길 65 ((1층))', '요리조리', '요리조리입니다. 좋은 서비스로 모시겠습니다.', '요리조리입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:351', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('353', '울산광역시 북구 치전2길 3 (양정동)', '대흥식육숯불생고기', '대흥식육숯불생고기입니다. 좋은 서비스로 모시겠습니다.', '대흥식육숯불생고기입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:352', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('354', '대전광역시 유성구 대학로 187 (어은동)', '전통순대국밥', '전통순대국밥입니다. 좋은 서비스로 모시겠습니다.', '전통순대국밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:353', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('355', '대전광역시 중구 동서대로 1379 (목동11. 115-515(1층))', '목동면옥', '목동면옥입니다. 좋은 서비스로 모시겠습니다.', '목동면옥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:354', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('356', '대전광역시 동구 용운동2길 24 (용운동)', '반가워식당', '반가워식당입니다. 좋은 서비스로 모시겠습니다.', '반가워식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:355', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('357', '광주광역시 북구 설죽로320번길 18 (오치동)', '함지박', '함지박입니다. 좋은 서비스로 모시겠습니다.', '함지박입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:356', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('358', '광주광역시 북구 밤실로 183 (두암동)', '최씨부엌족발', '최씨부엌족발입니다. 좋은 서비스로 모시겠습니다.', '최씨부엌족발입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:357', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('359', '광주광역시 서구 원마륵1길 12-11 (마륵동(일층))', '찌개로한식당외식사업부', '찌개로한식당외식사업부입니다. 좋은 서비스로 모시겠습니다.', '찌개로한식당외식사업부입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:358', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('360', '인천광역시 강화군 화도면 해안남로 1046 한자리한턱 23층 저장고1층', '한자리한턱', '한자리한턱입니다. 좋은 서비스로 모시겠습니다.', '한자리한턱입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:359', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('361', '인천광역시 부평구 마장로 489 (청천동아이즈빌아울렛2층2117호)', '코바코', '코바코입니다. 좋은 서비스로 모시겠습니다.', '코바코입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:360', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('362', '인천광역시 부평구 마장로 489 (청천동아이즈빌어울렛2136호)', '맛나다', '맛나다입니다. 좋은 서비스로 모시겠습니다.', '맛나다입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:361', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('363', '인천광역시 연수구 비류대로347번길 6 (연수동(지상1층))', '코리안숯불닭바베큐', '코리안숯불닭바베큐입니다. 좋은 서비스로 모시겠습니다.', '코리안숯불닭바베큐입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:362', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('364', '인천광역시 연수구 샘말로 55 지상2층 (연수동)', '비스트로 엠', '비스트로 엠입니다. 좋은 서비스로 모시겠습니다.', '비스트로 엠입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:363', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('365', '대구광역시 달서구 상화로 217 (상인동)', '참한손칼국수', '참한손칼국수입니다. 좋은 서비스로 모시겠습니다.', '참한손칼국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:364', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('366', '대구광역시 달서구 도원로 16 (도원동(지상1층))', '먹닭치킨호프', '먹닭치킨호프입니다. 좋은 서비스로 모시겠습니다.', '먹닭치킨호프입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:365', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('367', '대구광역시 북구 검단로 118 (검단동)', '빨간지붕', '빨간지붕입니다. 좋은 서비스로 모시겠습니다.', '빨간지붕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:366', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('368', '대구광역시 북구 산격로6길 23-1 (산격동)', '도깨비야시장', '도깨비야시장입니다. 좋은 서비스로 모시겠습니다.', '도깨비야시장입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:367', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('369', '대구광역시 서구 서대구로 110 (평리동)', '녹향구이식당', '녹향구이식당입니다. 좋은 서비스로 모시겠습니다.', '녹향구이식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:368', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('370', '대구광역시 서구 평리로 410 (내당동)', '강변메기매운탕', '강변메기매운탕입니다. 좋은 서비스로 모시겠습니다.', '강변메기매운탕입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:369', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('371', '대구광역시 동구 동부로30길 42-1 (신천동)', '바다이야기식당', '바다이야기식당입니다. 좋은 서비스로 모시겠습니다.', '바다이야기식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:370', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('372', '부산광역시 사상구 냉정로 105 (주례동)', '총각네 불막창곱창', '총각네 불막창곱창입니다. 좋은 서비스로 모시겠습니다.', '총각네 불막창곱창입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:371', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('373', '부산광역시 해운대구 재반로 77 (재송동 1층)', '미태리 부산 재송점', '미태리 부산 재송점입니다. 좋은 서비스로 모시겠습니다.', '미태리 부산 재송점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:372', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('374', '부산광역시 동래구 충렬대로181번길 41 (명륜동)', '우리동네 아쿠아리움 동래역점', '우리동네 아쿠아리움 동래역점입니다. 좋은 서비스로 모시겠습니다.', '우리동네 아쿠아리움 동래역점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:373', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('375', '서울특별시 송파구 마천로 80 지상1층 (오금동)', '전주콩나루콩나물국밥', '전주콩나루콩나물국밥입니다. 좋은 서비스로 모시겠습니다.', '전주콩나루콩나물국밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:374', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('376', '서울특별시 강남구 밤고개로1길 10 (수서동현대벤처빌 지하1층26호)', '써브웨이 수서역점', '써브웨이 수서역점입니다. 좋은 서비스로 모시겠습니다.', '써브웨이 수서역점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:375', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('377', '서울특별시 영등포구 영등포로41길 8 (영등포동5가)', '토종바로순대', '토종바로순대입니다. 좋은 서비스로 모시겠습니다.', '토종바로순대입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:376', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('378', '서울특별시 금천구 시흥대로88가길 3 (독산동지상1층 (호정3길11-1))', '옛날곱창', '옛날곱창입니다. 좋은 서비스로 모시겠습니다.', '옛날곱창입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:377', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('379', '서울특별시 강서구 강서로56가길 65 2층 (등촌동 3동)', '등촌샤브칼국수', '등촌샤브칼국수입니다. 좋은 서비스로 모시겠습니다.', '등촌샤브칼국수입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:378', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('380', '서울특별시 강북구 삼양로 657 1층 (우이동)', '우이령', '우이령입니다. 좋은 서비스로 모시겠습니다.', '우이령입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:379', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('381', '서울특별시 강북구 한천로 1020 (번동)', '실비집', '실비집입니다. 좋은 서비스로 모시겠습니다.', '실비집입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:380', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('382', '서울특별시 중랑구 용마산로129길 60 (신내동)', '본가왕해물찜', '본가왕해물찜입니다. 좋은 서비스로 모시겠습니다.', '본가왕해물찜입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:381', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('383', '서울특별시 동대문구 회기로13길 11 1층 (회기동)', '솔낭구', '솔낭구입니다. 좋은 서비스로 모시겠습니다.', '솔낭구입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:382', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('384', '서울특별시 광진구 면목로 87-1 (중곡동)', '옛추억', '옛추억입니다. 좋은 서비스로 모시겠습니다.', '옛추억입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:383', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('385', '서울특별시 용산구 한강대로104길 80 (후암동(2층))', '흥부네', '흥부네입니다. 좋은 서비스로 모시겠습니다.', '흥부네입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:384', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('386', '서울특별시 중구 퇴계로 397 (흥인동(1층))', '김밥천국', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:385', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('387', '서울특별시 종로구 우정국로2길 31 3층 (관철동)', '진삼거리포차', '진삼거리포차입니다. 좋은 서비스로 모시겠습니다.', '진삼거리포차입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:386', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('388', '제주특별자치도 서귀포시 대정읍 영서중로13번길 5', '영자네국밥', '영자네국밥입니다. 좋은 서비스로 모시겠습니다.', '영자네국밥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:387', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('389', '제주특별자치도 서귀포시 안덕면 사계남로216번길 24-73', '순천미향제주산방산본점', '순천미향제주산방산본점입니다. 좋은 서비스로 모시겠습니다.', '순천미향제주산방산본점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:388', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('390', '경기도 광주시 순암로 528 (삼동)', '보물촌꺼먹돼지', '보물촌꺼먹돼지입니다. 좋은 서비스로 모시겠습니다.', '보물촌꺼먹돼지입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:389', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('391', '경상남도 김해시 월산로 142 102호 (부곡동 월산마을부영아파트상가지하)', '호식이두마리치킨', '호식이두마리치킨입니다. 좋은 서비스로 모시겠습니다.', '호식이두마리치킨입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:390', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('392', '경상남도 진주시 도동천로 232 (하대동1층일부)', '회송송물회', '회송송물회입니다. 좋은 서비스로 모시겠습니다.', '회송송물회입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:391', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('393', '경상남도 진주시 상대로 149 (하대동1층)', '회머그로', '회머그로입니다. 좋은 서비스로 모시겠습니다.', '회머그로입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:392', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('394', '경상남도 진주시 하대로 71 (하대동1층)', '국민전통갈비진주점', '국민전통갈비진주점입니다. 좋은 서비스로 모시겠습니다.', '국민전통갈비진주점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:393', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('395', '경상북도 봉화군 명호면 봉명로 1004', '초가집식당', '초가집식당입니다. 좋은 서비스로 모시겠습니다.', '초가집식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:394', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('396', '경상북도 칠곡군 왜관읍 칠곡대로 1769', '고향맛기사식당', '고향맛기사식당입니다. 좋은 서비스로 모시겠습니다.', '고향맛기사식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:395', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('397', '경상북도 안동시 송천1길 112 (송천동)', '푸성귀', '푸성귀입니다. 좋은 서비스로 모시겠습니다.', '푸성귀입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:396', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('398', '경상북도 안동시 성곡1길 7 (용상동)', '술마셔라 적셔라', '술마셔라 적셔라입니다. 좋은 서비스로 모시겠습니다.', '술마셔라 적셔라입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:397', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('399', '경상북도 안동시 강남6길 5 1층 (정하동)', '강남상회', '강남상회입니다. 좋은 서비스로 모시겠습니다.', '강남상회입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:398', TRUE, TRUE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('400', '전라남도 화순군 도곡면 지강로 542 1동', '달맞이 흑두부', '달맞이 흑두부입니다. 좋은 서비스로 모시겠습니다.', '달맞이 흑두부입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:399', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('401', '전라남도 목포시 수문로20번길 7-3 (남교동)', '파라오', '파라오입니다. 좋은 서비스로 모시겠습니다.', '파라오입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:400', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('402', '전라남도 목포시 북항로 178 (죽교동)', '지도횟집', '지도횟집입니다. 좋은 서비스로 모시겠습니다.', '지도횟집입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:401', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('403', '전라북도 순창군 순창읍 신촌길 6', '수영가든', '수영가든입니다. 좋은 서비스로 모시겠습니다.', '수영가든입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:402', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('404', '전라북도 익산시 무왕로15길 9 (영등동(1층))', '일일수작 익산영등점1', '일일수작 익산영등점1입니다. 좋은 서비스로 모시겠습니다.', '일일수작 익산영등점1입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:403', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('405', '충청남도 공주시 정안면 논산천안고속도로 57 정안하행휴게소 1층', '키다리식품(주)정안(하)휴게소', '키다리식품(주)정안(하)휴게소입니다. 좋은 서비스로 모시겠습니다.', '키다리식품(주)정안(하)휴게소입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:404', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('406', '충청남도 공주시 이인면 논산천안고속도로 32', '주식회사케이알산업이인(상)휴게소생생돈가스', '주식회사케이알산업이인(상)휴게소생생돈가스입니다. 좋은 서비스로 모시겠습니다.', '주식회사케이알산업이인(상)휴게소생생돈가스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:405', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('407', '충청남도 공주시 정안면 논산천안고속도로 58 정안상행휴게소 2층', '2F양식', '2F양식입니다. 좋은 서비스로 모시겠습니다.', '2F양식입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:406', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('408', '충청남도 공주시 정안면 논산천안고속도로 58 정안상행휴게소 1층', '1F레스또란떼(양식)', '1F레스또란떼(양식)입니다. 좋은 서비스로 모시겠습니다.', '1F레스또란떼(양식)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:407', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('409', '충청남도 공주시 탄천면 논산천안고속도로 27 1층', '(주)케이알산업탄천(하)휴게소생생돈가스', '(주)케이알산업탄천(하)휴게소생생돈가스입니다. 좋은 서비스로 모시겠습니다.', '(주)케이알산업탄천(하)휴게소생생돈가스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:408', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('410', '강원도 강릉시 하슬라로232번길 11 (교동)', '일등짬뽕', '일등짬뽕입니다. 좋은 서비스로 모시겠습니다.', '일등짬뽕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:409', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('411', '경기도 구리시 아차산로 291 가동 1층 (교문동)', '한다리 백숙&샤브', '한다리 백숙&샤브입니다. 좋은 서비스로 모시겠습니다.', '한다리 백숙&샤브입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:410', TRUE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('412', '경기도 평택시 중앙1로 38 (통복동)', '진달래식당', '진달래식당입니다. 좋은 서비스로 모시겠습니다.', '진달래식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:411', TRUE, FALSE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('413', '경기도 평택시 청북읍 광승길 6', '양평해장국청북점', '양평해장국청북점입니다. 좋은 서비스로 모시겠습니다.', '양평해장국청북점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:412', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('414', '경기도 부천시 경인로 92 123층 (송내동)', '한촌', '한촌입니다. 좋은 서비스로 모시겠습니다.', '한촌입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:413', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('415', '경기도 성남시 분당구 돌마로 75 (금곡동미금프라자 1층110호)', '곱창고 미금역점', '곱창고 미금역점입니다. 좋은 서비스로 모시겠습니다.', '곱창고 미금역점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:414', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('416', '경기도 수원시 영통구 매봉로27번길 28 (매탄동)', '늘푸른밥상', '늘푸른밥상입니다. 좋은 서비스로 모시겠습니다.', '늘푸른밥상입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:415', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('417', '울산광역시 남구 문수로369번길 44 (옥동)', '시골민속촌', '시골민속촌입니다. 좋은 서비스로 모시겠습니다.', '시골민속촌입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:416', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('418', '대전광역시 대덕구 선비마을로 22 (송촌동)', '포대포생소곱창구이식당', '포대포생소곱창구이식당입니다. 좋은 서비스로 모시겠습니다.', '포대포생소곱창구이식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:417', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('419', '대전광역시 대덕구 우암로 404 (비래동45-2)', '아줌마김밥식당', '아줌마김밥식당입니다. 좋은 서비스로 모시겠습니다.', '아줌마김밥식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:418', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('420', '대전광역시 대덕구 송촌남로 63 1층 (송촌동)', '매운삼겹살식당', '매운삼겹살식당입니다. 좋은 서비스로 모시겠습니다.', '매운삼겹살식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:419', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('421', '대전광역시 서구 신갈마로 267 (갈마동)', '찡어야', '찡어야입니다. 좋은 서비스로 모시겠습니다.', '찡어야입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:420', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('422', '대전광역시 서구 도마로 19 (도마동)', '돈방제주맛돼지', '돈방제주맛돼지입니다. 좋은 서비스로 모시겠습니다.', '돈방제주맛돼지입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:421', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('423', '광주광역시 서구 상무시민로 97-5 (치평동(오층))', '리치', '리치입니다. 좋은 서비스로 모시겠습니다.', '리치입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:422', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('424', '인천광역시 부평구 영성서로 23-7 (삼산동)', '돼지발', '돼지발입니다. 좋은 서비스로 모시겠습니다.', '돼지발입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:423', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('425', '부산광역시 연제구 쌍미천로151번길 31 (연산동)', '디딤돌', '디딤돌입니다. 좋은 서비스로 모시겠습니다.', '디딤돌입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:424', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('426', '부산광역시 사하구 낙동대로 123 (괴정동)', '한패 부산본점', '한패 부산본점입니다. 좋은 서비스로 모시겠습니다.', '한패 부산본점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:425', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('427', '서울특별시 관악구 남부순환로 1620 (신림동)', '북경반점', '북경반점입니다. 좋은 서비스로 모시겠습니다.', '북경반점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:426', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('428', '서울특별시 종로구 대학로11길 41-4 (명륜4가)', '뎁짜이', '뎁짜이입니다. 좋은 서비스로 모시겠습니다.', '뎁짜이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:427', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('429', '세종특별자치시 조치원읍 봉산로 7 1층', '어머님칼국수', '어머님칼국수입니다. 좋은 서비스로 모시겠습니다.', '어머님칼국수입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:428', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('430', '충청남도 당진시 석문면 대호로 1554-20', '성도연탄구이', '성도연탄구이입니다. 좋은 서비스로 모시겠습니다.', '성도연탄구이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:429', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('431', '경상남도 창원시 진해구 냉천로62번길 23 (석동)', '고산흑염소 진해점', '고산흑염소 진해점입니다. 좋은 서비스로 모시겠습니다.', '고산흑염소 진해점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:430', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('432', '경기도 양주시 어하고개로 135 1층 (삼숭동)', '전주옥', '전주옥입니다. 좋은 서비스로 모시겠습니다.', '전주옥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:431', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('433', '경상남도 하동군 금성면 신도길 132', '제일숯불갈비', '제일숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '제일숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:432', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('434', '경상남도 양산시 양주2길 33 1층 (중부동)', '원조매콤이와순진이', '원조매콤이와순진이입니다. 좋은 서비스로 모시겠습니다.', '원조매콤이와순진이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:433', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('435', '경상북도 칠곡군 지천면 칠곡대로 2297', '홍이 짬뽕나라', '홍이 짬뽕나라입니다. 좋은 서비스로 모시겠습니다.', '홍이 짬뽕나라입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:434', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('436', '경상북도 칠곡군 북삼읍 안산2길 20', '사랑해사랑해숭오점', '사랑해사랑해숭오점입니다. 좋은 서비스로 모시겠습니다.', '사랑해사랑해숭오점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:435', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('437', '경상북도 경주시 불국로 197 (마동)', '최박사', '최박사입니다. 좋은 서비스로 모시겠습니다.', '최박사입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:436', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('438', '경상북도 경주시 초당길141번길 18 (동천동)', '장우동', '장우동입니다. 좋은 서비스로 모시겠습니다.', '장우동입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:437', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('439', '경상북도 경주시 승삼3길 14-9 (용강동)', '성지골', '성지골입니다. 좋은 서비스로 모시겠습니다.', '성지골입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:438', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('440', '경상북도 경주시 양정로290번길 14 (동천동)', '돈짱', '돈짱입니다. 좋은 서비스로 모시겠습니다.', '돈짱입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:439', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('441', '경상북도 경주시 산업로 3036-10 (구정동)', '골목식당', '골목식당입니다. 좋은 서비스로 모시겠습니다.', '골목식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:440', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('442', '경상북도 포항시 남구 포스코대로 64 (이동)', '황금오리식당', '황금오리식당입니다. 좋은 서비스로 모시겠습니다.', '황금오리식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:441', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('443', '전라남도 완도군 약산면 장용1길 7', '카라호프', '카라호프입니다. 좋은 서비스로 모시겠습니다.', '카라호프입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:442', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('444', '전라남도 완도군 완도읍 장보고대로 174-2', '종로김밥', '종로김밥입니다. 좋은 서비스로 모시겠습니다.', '종로김밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:443', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('445', '전라남도 해남군 해남읍 북부순환로 158', '매운양푼이갈비', '매운양푼이갈비입니다. 좋은 서비스로 모시겠습니다.', '매운양푼이갈비입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:444', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('446', '전라남도 여수시 신기남1길 14 (신기동)', '밥통분식', '밥통분식입니다. 좋은 서비스로 모시겠습니다.', '밥통분식입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:445', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('447', '전라남도 여수시 대치3길 13-1 (여서동)', '네네치킨여서점', '네네치킨여서점입니다. 좋은 서비스로 모시겠습니다.', '네네치킨여서점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:446', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('448', '전라남도 목포시 산정로22번길 13 1층 (산정동)', '속풀이', '속풀이입니다. 좋은 서비스로 모시겠습니다.', '속풀이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:447', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('449', '전라북도 무주군 설천면 만선1로 60', '가족마당', '가족마당입니다. 좋은 서비스로 모시겠습니다.', '가족마당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:448', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('450', '전라북도 군산시 두란뜸2길 3 (사정동)', '치킨하우스', '치킨하우스입니다. 좋은 서비스로 모시겠습니다.', '치킨하우스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:449', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('451', '충청남도 천안시 서북구 차돌들길 10 (쌍용동)', '비어엔조이천안점', '비어엔조이천안점입니다. 좋은 서비스로 모시겠습니다.', '비어엔조이천안점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:450', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('452', '충청북도 제천시 칠성로9길 25 (청전동(1층))', '청풍참숯불구이', '청풍참숯불구이입니다. 좋은 서비스로 모시겠습니다.', '청풍참숯불구이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:451', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('453', '강원도 삼척시 원덕읍 임원항구로 25-2', '왕고래초밥김밥', '왕고래초밥김밥입니다. 좋은 서비스로 모시겠습니다.', '왕고래초밥김밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:452', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('454', '강원도 강릉시 연곡면 진고개로 2697-10', '황토금강식당', '황토금강식당입니다. 좋은 서비스로 모시겠습니다.', '황토금강식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:453', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('455', '강원도 강릉시 옥가로7번길 14 (옥천동)', '추억의맛집', '추억의맛집입니다. 좋은 서비스로 모시겠습니다.', '추억의맛집입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:454', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('456', '강원도 춘천시 동내면 거두택지길 93-7', '춘천댐촌닭집거두점', '춘천댐촌닭집거두점입니다. 좋은 서비스로 모시겠습니다.', '춘천댐촌닭집거두점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:455', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('457', '경기도 연천군 전곡읍 은전로86번길 21', '디네트', '디네트입니다. 좋은 서비스로 모시겠습니다.', '디네트입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:456', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('458', '경기도 용인시 처인구 포곡읍 포곡로118번길 19', '진진양꼬치', '진진양꼬치입니다. 좋은 서비스로 모시겠습니다.', '진진양꼬치입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:457', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('459', '경기도 용인시 처인구 백옥대로 1225 (유방동)', '우리설렁탕', '우리설렁탕입니다. 좋은 서비스로 모시겠습니다.', '우리설렁탕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:458', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('460', '경기도 의왕시 갈미2로 14 (내손동리치21 202호)', '동보성', '동보성입니다. 좋은 서비스로 모시겠습니다.', '동보성입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:459', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('461', '경기도 군포시 당산로 121 B동 지층 (금정동)', '별', '별입니다. 좋은 서비스로 모시겠습니다.', '별입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:460', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('462', '경기도 시흥시 군자천로 381-1 시화병원 1층 일부호 (정왕동)', '시화병원장례식장', '시화병원장례식장입니다. 좋은 서비스로 모시겠습니다.', '시화병원장례식장입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:461', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('463', '경기도 고양시 일산서구 가좌1로 38 103호 (가좌동 가좌마을3단지상가동)', '토크쇼', '토크쇼입니다. 좋은 서비스로 모시겠습니다.', '토크쇼입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:462', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('464', '경기도 안산시 상록구 반석로 106-1 1층 (본오동)', '택이네', '택이네입니다. 좋은 서비스로 모시겠습니다.', '택이네입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:463', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('465', '경기도 평택시 중앙1로 32 (통복동)', '새둥지식당', '새둥지식당입니다. 좋은 서비스로 모시겠습니다.', '새둥지식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:464', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('466', '경기도 부천시 길주로 118 삼성홈플러스상동 1층 일부 (상동)', '카마타케제면소', '카마타케제면소입니다. 좋은 서비스로 모시겠습니다.', '카마타케제면소입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:465', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('467', '경기도 안양시 동안구 관평로170번길 33 (관양동 평촌주공공이204호)', '쥰스시', '쥰스시입니다. 좋은 서비스로 모시겠습니다.', '쥰스시입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:466', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('468', '경기도 의정부시 태평로 101-1 (의정부동지상1층)', '김밥천국', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:467', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('469', '경기도 성남시 중원구 희망로344번길 4 1층 (상대원동)', '명가통닭', '명가통닭입니다. 좋은 서비스로 모시겠습니다.', '명가통닭입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:468', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('470', '경기도 성남시 분당구 백현로101번길 16 (수내동대덕프라자 2층 207호)', '단가마 감자탕', '단가마 감자탕입니다. 좋은 서비스로 모시겠습니다.', '단가마 감자탕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:469', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('471', '경기도 수원시 영통구 삼성로168번길 100 (매탄동)', '하오츠(삼성점)', '하오츠(삼성점)입니다. 좋은 서비스로 모시겠습니다.', '하오츠(삼성점)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:470', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('472', '경기도 수원시 영통구 매여울로40번길 50 (매탄동)', '지니초밥', '지니초밥입니다. 좋은 서비스로 모시겠습니다.', '지니초밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:471', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('473', '경기도 수원시 권선구 세권로42번길 3 (세류동1층)', '송원동태전문점', '송원동태전문점입니다. 좋은 서비스로 모시겠습니다.', '송원동태전문점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:472', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('474', '울산광역시 울주군 서생면 진하길 53 1층', '나들목식당', '나들목식당입니다. 좋은 서비스로 모시겠습니다.', '나들목식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:473', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('475', '울산광역시 중구 성안로 201 (성안동)', '종로쭈꾸미성안점', '종로쭈꾸미성안점입니다. 좋은 서비스로 모시겠습니다.', '종로쭈꾸미성안점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:474', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('476', '대전광역시 대덕구 신탄진로218번길 47 (와동)', '맛고을식당', '맛고을식당입니다. 좋은 서비스로 모시겠습니다.', '맛고을식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:475', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('477', '대전광역시 유성구 전민로22번길 25 (전민동)', '함지박', '함지박입니다. 좋은 서비스로 모시겠습니다.', '함지박입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:476', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('478', '대전광역시 중구 중교로 25 (대흥동(1층))', '엄마손김밥', '엄마손김밥입니다. 좋은 서비스로 모시겠습니다.', '엄마손김밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:477', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('479', '광주광역시 광산구 고봉로258번길 43-9 (장수동)', '어등골', '어등골입니다. 좋은 서비스로 모시겠습니다.', '어등골입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:478', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('480', '광주광역시 서구 풍암신흥로 59 (풍암동(1층))', '하얀성', '하얀성입니다. 좋은 서비스로 모시겠습니다.', '하얀성입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:479', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('481', '광주광역시 서구 풍암2로53번길 6-1 2층 (풍암동)', '레몬', '레몬입니다. 좋은 서비스로 모시겠습니다.', '레몬입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:480', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('482', '인천광역시 계양구 길마로 70 1층 101호 (효성동 현대아파트상가)', '교촌치킨', '교촌치킨입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:481', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('483', '인천광역시 계양구 효서로 353-1 (작전동)', '곰달구', '곰달구입니다. 좋은 서비스로 모시겠습니다.', '곰달구입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:482', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('484', '인천광역시 남동구 문화서로 14 1층 (구월동)', '옹골진푸드마을', '옹골진푸드마을입니다. 좋은 서비스로 모시겠습니다.', '옹골진푸드마을입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:483', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('485', '인천광역시 연수구 청능대로 210 (동춘동 지하1층 일부 홈플러스연수점 푸드코트내)', '도쿄짬뽕', '도쿄짬뽕입니다. 좋은 서비스로 모시겠습니다.', '도쿄짬뽕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:484', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('486', '대구광역시 달서구 두류공원로50길 17 (두류동)', '가야산식당', '가야산식당입니다. 좋은 서비스로 모시겠습니다.', '가야산식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:485', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('487', '대구광역시 수성구 들안로 19 (상동)', '(주)민수사', '(주)민수사입니다. 좋은 서비스로 모시겠습니다.', '(주)민수사입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:486', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('488', '대구광역시 동구 서촌로 145-11 (송정동)', '송지연', '송지연입니다. 좋은 서비스로 모시겠습니다.', '송지연입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:487', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('489', '부산광역시 남구 수영로322번길 22 3층 301호 (대연동)', '블랙레이디 경성대점', '블랙레이디 경성대점입니다. 좋은 서비스로 모시겠습니다.', '블랙레이디 경성대점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:488', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('490', '부산광역시 부산진구 가야대로703번길 25 (당감동)', '일품정가', '일품정가입니다. 좋은 서비스로 모시겠습니다.', '일품정가입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:489', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('491', '부산광역시 서구 대신공원로 13-5 101호 (동대신동3가 베스트빌라)', '편의방', '편의방입니다. 좋은 서비스로 모시겠습니다.', '편의방입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:490', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('492', '서울특별시 동작구 노량진로 2 (대방동)', '씨제이푸드빌(주)빕스 대방점', '씨제이푸드빌(주)빕스 대방점입니다. 좋은 서비스로 모시겠습니다.', '씨제이푸드빌(주)빕스 대방점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:491', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('493', '서울특별시 영등포구 영등포로 106 (당산동2가대우(아) 102동상가 113호)', '오이삼계탕', '오이삼계탕입니다. 좋은 서비스로 모시겠습니다.', '오이삼계탕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:492', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('494', '서울특별시 영등포구 영중로4길 13-1 (영등포동3가 1층)', '영등포치킨골뱅이', '영등포치킨골뱅이입니다. 좋은 서비스로 모시겠습니다.', '영등포치킨골뱅이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:493', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('495', '서울특별시 구로구 경인로40길 11 영화아파트 상가동 1층 102호 (개봉동 영화아파트)', '우리동네김밥', '우리동네김밥입니다. 좋은 서비스로 모시겠습니다.', '우리동네김밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:494', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('496', '서울특별시 양천구 월정로29길 15 (신월동)', '월산', '월산입니다. 좋은 서비스로 모시겠습니다.', '월산입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:495', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('497', '서울특별시 양천구 목동동로 379 (목동광장종합상가 2층 206207호)', '수미가샤브샤브', '수미가샤브샤브입니다. 좋은 서비스로 모시겠습니다.', '수미가샤브샤브입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:496', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('498', '서울특별시 강북구 노해로8길 34 (수유동)', '구락부 사이야', '구락부 사이야입니다. 좋은 서비스로 모시겠습니다.', '구락부 사이야입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:497', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('499', '서울특별시 중랑구 겸재로 264 (면목동)', '사랑방', '사랑방입니다. 좋은 서비스로 모시겠습니다.', '사랑방입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:498', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('500', '서울특별시 중랑구 면목로45길 3-8 (면목동6층)', '벨(Bell)', '벨(Bell)입니다. 좋은 서비스로 모시겠습니다.', '벨(Bell)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:499', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('501', '서울특별시 용산구 한강대로62길 25 (한강로1가(1층))', '카지츠', '카지츠입니다. 좋은 서비스로 모시겠습니다.', '카지츠입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:500', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('502', '서울특별시 용산구 원효로48길 11-8 (원효로2가(지상1층))', '붉은돼지', '붉은돼지입니다. 좋은 서비스로 모시겠습니다.', '붉은돼지입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:501', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('503', '서울특별시 중구 퇴계로 423-10 (황학동(1층))', '장군보쌈', '장군보쌈입니다. 좋은 서비스로 모시겠습니다.', '장군보쌈입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:502', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('504', '서울특별시 중구 서소문로9길 6 (순화동(1층))', '동강', '동강입니다. 좋은 서비스로 모시겠습니다.', '동강입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:503', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('505', '서울특별시 종로구 대명1길 23 12층 (명륜4가)', '혜화양육관', '혜화양육관입니다. 좋은 서비스로 모시겠습니다.', '혜화양육관입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:504', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('506', '제주특별자치도 서귀포시 동홍남로 77 (동홍동)', '모닝해장국', '모닝해장국입니다. 좋은 서비스로 모시겠습니다.', '모닝해장국입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:505', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('507', '충청북도 청주시 청원구 우암로20번길 25 (우암동)', '송사리식당', '송사리식당입니다. 좋은 서비스로 모시겠습니다.', '송사리식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:506', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('508', '경상남도 창원시 성산구 두대로55번길 10 1층 102호103호 (대원동 동우위너스코아)', '교촌치킨(대원점)', '교촌치킨(대원점)입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨(대원점)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:507', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('509', '경기도 광주시 경충대로 1744 (역동)', '경안장례식장가든(매점)', '경안장례식장가든(매점)입니다. 좋은 서비스로 모시겠습니다.', '경안장례식장가든(매점)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:508', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('510', '경상남도 하동군 하동읍 섬진강대로 2483', '재첩잡는선장집', '재첩잡는선장집입니다. 좋은 서비스로 모시겠습니다.', '재첩잡는선장집입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:509', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('511', '경상남도 거제시 아주로3길 15 (아주동(1층))', '허삼동짬뽕', '허삼동짬뽕입니다. 좋은 서비스로 모시겠습니다.', '허삼동짬뽕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:510', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('512', '경상남도 거제시 장평3로7길 47-1 (장평동)', '양지촌', '양지촌입니다. 좋은 서비스로 모시겠습니다.', '양지촌입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:511', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('513', '경상남도 거제시 장승포로 49 (장승포동신부월드상가 105호)', '남강추어탕', '남강추어탕입니다. 좋은 서비스로 모시겠습니다.', '남강추어탕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:512', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('514', '경상남도 김해시 분성로 347-1 (동상동)', '성현암 사찰음식', '성현암 사찰음식입니다. 좋은 서비스로 모시겠습니다.', '성현암 사찰음식입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:513', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('515', '경상남도 통영시 원문로 11 102동 2호 (북신동 진우마리나타운)', '모란포차', '모란포차입니다. 좋은 서비스로 모시겠습니다.', '모란포차입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:514', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('516', '경상북도 청송군 진보면 진안로 4', '사또숯불갈비', '사또숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '사또숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:515', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('517', '경상북도 경산시 중앙로16길 4 (중방동)', '마이하우스', '마이하우스입니다. 좋은 서비스로 모시겠습니다.', '마이하우스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:516', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('518', '경상북도 문경시 문경읍 주흘1길 25', '굽네치킨 문경새재점', '굽네치킨 문경새재점입니다. 좋은 서비스로 모시겠습니다.', '굽네치킨 문경새재점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:517', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('519', '경상북도 김천시 남면 농남로 1052', '부자보리밥', '부자보리밥입니다. 좋은 서비스로 모시겠습니다.', '부자보리밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:518', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('520', '경상북도 김천시 신음새동네2길 43 (신음동)', '권가네치킨', '권가네치킨입니다. 좋은 서비스로 모시겠습니다.', '권가네치킨입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:519', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('521', '경상북도 포항시 북구 양학천로 21 (죽도동(1층))', '대덕막창', '대덕막창입니다. 좋은 서비스로 모시겠습니다.', '대덕막창입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:520', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('522', '전라남도 고흥군 고흥읍 봉동주공길 28', '마포참숯왕갈비', '마포참숯왕갈비입니다. 좋은 서비스로 모시겠습니다.', '마포참숯왕갈비입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:521', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('523', '전라남도 담양군 담양읍 삼거리길 8-6', '축협한우전문식당2호점', '축협한우전문식당2호점입니다. 좋은 서비스로 모시겠습니다.', '축협한우전문식당2호점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:522', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('524', '전라남도 광양시 광양읍 인서중앙길 46 ((1층))', '남양옹기촌', '남양옹기촌입니다. 좋은 서비스로 모시겠습니다.', '남양옹기촌입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:523', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('525', '전라남도 여수시 시청서4길 26-6 (학동)', '청양', '청양입니다. 좋은 서비스로 모시겠습니다.', '청양입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:524', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('526', '전라북도 익산시 고봉로28길 32 (영등동외1필지(1층))', '우박집(영등점)', '우박집(영등점)입니다. 좋은 서비스로 모시겠습니다.', '우박집(영등점)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:525', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('527', '전라북도 전주시 완산구 평화14길 34-14 (평화동1가)', '심원아구', '심원아구입니다. 좋은 서비스로 모시겠습니다.', '심원아구입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:526', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('528', '충청남도 아산시 번영로85번길 8 (온천동)', '어두육미', '어두육미입니다. 좋은 서비스로 모시겠습니다.', '어두육미입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:527', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('529', '충청남도 천안시 서북구 성환읍 연암율금로 399-7', '용궁가든', '용궁가든입니다. 좋은 서비스로 모시겠습니다.', '용궁가든입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:528', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('530', '충청북도 음성군 금왕읍 금일로534번길 4', '최장군식당', '최장군식당입니다. 좋은 서비스로 모시겠습니다.', '최장군식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:529', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('531', '충청북도 충주시 중앙탑면 중부내륙고속도로 230-1', '충주휴게소 한식(상행)', '충주휴게소 한식(상행)입니다. 좋은 서비스로 모시겠습니다.', '충주휴게소 한식(상행)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:530', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('532', '충청북도 충주시 중앙탑면 중부내륙고속도로 230-1', '충주(상)휴게소 우동/라면', '충주(상)휴게소 우동/라면입니다. 좋은 서비스로 모시겠습니다.', '충주(상)휴게소 우동/라면입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:531', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('533', '충청북도 충주시 중앙탑면 중부내륙고속도로 230-1', '충주(상)휴게소 귀신반점', '충주(상)휴게소 귀신반점입니다. 좋은 서비스로 모시겠습니다.', '충주(상)휴게소 귀신반점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:532', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('534', '충청북도 충주시 천변로 293-1 (교현동)', '놀러와요', '놀러와요입니다. 좋은 서비스로 모시겠습니다.', '놀러와요입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:533', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('535', '충청북도 충주시 중앙탑면 중부내륙고속도로 231', '(주)인앤아웃충주(창원)휴게소한식2', '(주)인앤아웃충주(창원)휴게소한식2입니다. 좋은 서비스로 모시겠습니다.', '(주)인앤아웃충주(창원)휴게소한식2입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:534', TRUE, FALSE, FALSE, TRUE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('536', '충청북도 충주시 중앙탑면 중부내륙고속도로 231', '(주)인앤아웃충주(창원)휴게소한식1', '(주)인앤아웃충주(창원)휴게소한식1입니다. 좋은 서비스로 모시겠습니다.', '(주)인앤아웃충주(창원)휴게소한식1입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:535', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('537', '충청북도 충주시 중앙탑면 중부내륙고속도로 231', '(주)인앤아웃충주(창원)휴게소우동', '(주)인앤아웃충주(창원)휴게소우동입니다. 좋은 서비스로 모시겠습니다.', '(주)인앤아웃충주(창원)휴게소우동입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:536', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('538', '충청북도 충주시 중앙탑면 중부내륙고속도로 231', '(주)인앤아웃충주(창원)휴게소양식', '(주)인앤아웃충주(창원)휴게소양식입니다. 좋은 서비스로 모시겠습니다.', '(주)인앤아웃충주(창원)휴게소양식입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:537', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('539', '충청북도 충주시 중앙탑면 중부내륙고속도로 231', '(주)인앤아웃충주(창원)휴게소라면', '(주)인앤아웃충주(창원)휴게소라면입니다. 좋은 서비스로 모시겠습니다.', '(주)인앤아웃충주(창원)휴게소라면입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:538', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('540', '강원도 홍천군 동면 공작산로 1326', '솟대쉼터', '솟대쉼터입니다. 좋은 서비스로 모시겠습니다.', '솟대쉼터입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:539', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('541', '경기도 김포시 통진읍 서암로 340', '전주기사부페', '전주기사부페입니다. 좋은 서비스로 모시겠습니다.', '전주기사부페입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:540', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('542', '경기도 파주시 중앙로 74 (금능동)', '의정부부대찌개', '의정부부대찌개입니다. 좋은 서비스로 모시겠습니다.', '의정부부대찌개입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:541', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('543', '경기도 용인시 처인구 금령로39번길 9 (김량장동)', '세븐', '세븐입니다. 좋은 서비스로 모시겠습니다.', '세븐입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:542', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('544', '경기도 시흥시 대골안길 96 1층 (신천동)', '싱싱수산시장', '싱싱수산시장입니다. 좋은 서비스로 모시겠습니다.', '싱싱수산시장입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:543', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('545', '경기도 남양주시 별내면 청학로중앙길 5', '인터뷰', '인터뷰입니다. 좋은 서비스로 모시겠습니다.', '인터뷰입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:544', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('546', '경기도 안산시 단원구 다문화2길 28 (원곡동 794  2층)', '칸티뿌르레스토랑(KANTIPUR RESTAURANT INDIAN NEPAL FOOD)', '칸티뿌르레스토랑(KANTIPUR RESTAURANT INDIAN NEPAL FOOD)입니다. 좋은 서비스로 모시겠습니다.', '칸티뿌르레스토랑(KANTIPUR RESTAURANT INDIAN NEPAL FOOD)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:545', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('547', '경기도 평택시 자유로19번길 3 (평택동)', '선술집모로미식당', '선술집모로미식당입니다. 좋은 서비스로 모시겠습니다.', '선술집모로미식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:546', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('548', '경기도 안양시 동안구 인덕원로16번길 19 (관양동 1층)', '연탄불막창', '연탄불막창입니다. 좋은 서비스로 모시겠습니다.', '연탄불막창입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:547', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('549', '경기도 의정부시 행복로 23-1 (의정부동지상2층)', '꼬시나떡볶이전문점', '꼬시나떡볶이전문점입니다. 좋은 서비스로 모시겠습니다.', '꼬시나떡볶이전문점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:548', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('550', '경기도 성남시 수정구 수정남로56번길 20-1 (수진동)', '산성분식', '산성분식입니다. 좋은 서비스로 모시겠습니다.', '산성분식입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:549', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('551', '경기도 수원시 영통구 매탄로 49 1층 101102호 (매탄동)', '쓰촨쿵푸 양꼬치&마라탕', '쓰촨쿵푸 양꼬치&마라탕입니다. 좋은 서비스로 모시겠습니다.', '쓰촨쿵푸 양꼬치&마라탕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:550', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('552', '울산광역시 남구 수암로 241-2 (야음동(지상1층))', '처가집양념통닭', '처가집양념통닭입니다. 좋은 서비스로 모시겠습니다.', '처가집양념통닭입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:551', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('553', '대전광역시 대덕구 석봉로37번길 8 1층 (석봉동)', '이글스직화짬뽕', '이글스직화짬뽕입니다. 좋은 서비스로 모시겠습니다.', '이글스직화짬뽕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:552', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('554', '대전광역시 유성구 노은동로79번길 10 (노은동)', '원갈치조림', '원갈치조림입니다. 좋은 서비스로 모시겠습니다.', '원갈치조림입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:553', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('555', '대전광역시 서구 둔산중로134번길 29 (둔산동(2층))', '아우네부대찌개', '아우네부대찌개입니다. 좋은 서비스로 모시겠습니다.', '아우네부대찌개입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:554', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('556', '대전광역시 서구 둔산로31번길 34 (둔산동3층)', '슈퍼맨', '슈퍼맨입니다. 좋은 서비스로 모시겠습니다.', '슈퍼맨입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:555', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('557', '대전광역시 서구 갈마로 55 (갈마동(1층))', '김밥천국', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:556', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('558', '인천광역시 미추홀구 낙섬서로 30-1 (용현동)', '화척', '화척입니다. 좋은 서비스로 모시겠습니다.', '화척입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:557', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('559', '대구광역시 중구 경상감영1길 43 (대안동)', '다락방', '다락방입니다. 좋은 서비스로 모시겠습니다.', '다락방입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:558', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('560', '부산광역시 사하구 동매로 27 (하단동)', '풀하우스', '풀하우스입니다. 좋은 서비스로 모시겠습니다.', '풀하우스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:559', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('561', '부산광역시 사하구 낙동대로516번길 24 (하단동)', '고수', '고수입니다. 좋은 서비스로 모시겠습니다.', '고수입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:560', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('562', '부산광역시 동래구 충렬대로 149 (온천동)', '주식회사세연정', '주식회사세연정입니다. 좋은 서비스로 모시겠습니다.', '주식회사세연정입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:561', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('563', '부산광역시 부산진구 새싹로 256 (초읍동 오티시이즈오피스텔 102호일부)', '영일횟집', '영일횟집입니다. 좋은 서비스로 모시겠습니다.', '영일횟집입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:562', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('564', '부산광역시 동구 중앙대로236번길 3-4 (초량동)', '하버뷔페', '하버뷔페입니다. 좋은 서비스로 모시겠습니다.', '하버뷔페입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:563', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('565', '서울특별시 강남구 압구정로72길 26 (청담동지상1층)', '씨즌스', '씨즌스입니다. 좋은 서비스로 모시겠습니다.', '씨즌스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:564', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('566', '서울특별시 양천구 목동중앙본로 72 (목동)', '성지식당', '성지식당입니다. 좋은 서비스로 모시겠습니다.', '성지식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:565', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('567', '서울특별시 마포구 백범로36길 12 (염리동)', '모로미쿠시', '모로미쿠시입니다. 좋은 서비스로 모시겠습니다.', '모로미쿠시입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:566', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('568', '서울특별시 서대문구 연세로2길 83 대한일보신촌지국 (대현동)', '동강참치', '동강참치입니다. 좋은 서비스로 모시겠습니다.', '동강참치입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:567', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('569', '서울특별시 노원구 노원로 330 롯데마트 지하1층 (중계동)', '예당', '예당입니다. 좋은 서비스로 모시겠습니다.', '예당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:568', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('570', '서울특별시 노원구 노원로 330 롯데마트 지하1층 (중계동)', '양푼비빔밥', '양푼비빔밥입니다. 좋은 서비스로 모시겠습니다.', '양푼비빔밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:569', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('571', '서울특별시 노원구 노원로 330 롯데마트 지하1층 (중계동)', '돈까스아찌', '돈까스아찌입니다. 좋은 서비스로 모시겠습니다.', '돈까스아찌입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:570', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('572', '서울특별시 종로구 북촌로 20 (재동)', '재동식당', '재동식당입니다. 좋은 서비스로 모시겠습니다.', '재동식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:571', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('573', '서울특별시 종로구 종로31길 10 (종로5가)', '야젠', '야젠입니다. 좋은 서비스로 모시겠습니다.', '야젠입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:572', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('574', '충청북도 청주시 서원구 수곡로37번길 16-1 1층 (수곡동)', '먹방생고기', '먹방생고기입니다. 좋은 서비스로 모시겠습니다.', '먹방생고기입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:573', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('575', '충청북도 청주시 서원구 구룡산로 393-1 (수곡동(1층))', '도원골', '도원골입니다. 좋은 서비스로 모시겠습니다.', '도원골입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:574', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('576', '세종특별자치시 부강면 부강1길 7', '동해바다회', '동해바다회입니다. 좋은 서비스로 모시겠습니다.', '동해바다회입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:575', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('577', '경상남도 창원시 성산구 단정로 29 (상남동태우라메르빌딩1101호1201호)', '지직스', '지직스입니다. 좋은 서비스로 모시겠습니다.', '지직스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:576', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('578', '경상남도 창원시 성산구 대정로35번길 11 (가음동1층)', '김밥나라', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:577', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('579', '충청남도 계룡시 엄사면 번영7길 6', '상아정육식당', '상아정육식당입니다. 좋은 서비스로 모시겠습니다.', '상아정육식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:578', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('580', '경기도 화성시 팔탄면 노하길 132 1층', '치킨먹고피자먹고', '치킨먹고피자먹고입니다. 좋은 서비스로 모시겠습니다.', '치킨먹고피자먹고입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:579', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('581', '경기도 화성시 팔탄면 시청로 822 2층', '고향솥단지삼겹살', '고향솥단지삼겹살입니다. 좋은 서비스로 모시겠습니다.', '고향솥단지삼겹살입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:580', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('582', '경상남도 산청군 산청읍 웅석봉로68번길 4', '옥산식당', '옥산식당입니다. 좋은 서비스로 모시겠습니다.', '옥산식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:581', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('583', '경상남도 양산시 외산3길 10-9 (덕계동)', '산아래그집', '산아래그집입니다. 좋은 서비스로 모시겠습니다.', '산아래그집입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:582', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('584', '경상남도 김해시 삼안로154번길 5 1층 (삼방동)', '신불닭발', '신불닭발입니다. 좋은 서비스로 모시겠습니다.', '신불닭발입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:583', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('585', '경상북도 예천군 지보면 지보로 168-7', '금잔디식당', '금잔디식당입니다. 좋은 서비스로 모시겠습니다.', '금잔디식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:584', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('586', '경상북도 영천시 문화원길 21-4 (문내동)', '쵸이스휴게레스토랑', '쵸이스휴게레스토랑입니다. 좋은 서비스로 모시겠습니다.', '쵸이스휴게레스토랑입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:585', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('587', '경상북도 구미시 금오산로 217-16 (남통동  파크비지니스관광호텔)', '호텔파크비지니스(양식당)', '호텔파크비지니스(양식당)입니다. 좋은 서비스로 모시겠습니다.', '호텔파크비지니스(양식당)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:586', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('588', '경상북도 포항시 북구 삼호로 232 (두호동(2층))', '지유', '지유입니다. 좋은 서비스로 모시겠습니다.', '지유입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:587', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('589', '전라남도 여수시 소라면 서부로 986', '아델라', '아델라입니다. 좋은 서비스로 모시겠습니다.', '아델라입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:588', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('590', '전라남도 목포시 영산로 62-1 (무안동)', '진동회집', '진동회집입니다. 좋은 서비스로 모시겠습니다.', '진동회집입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:589', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('591', '전라남도 목포시 북항로 178 1층 (죽교동)', '인어횟집', '인어횟집입니다. 좋은 서비스로 모시겠습니다.', '인어횟집입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:590', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('592', '전라북도 정읍시 벚꽃로 546 (상동)', '벚꽃길가든', '벚꽃길가든입니다. 좋은 서비스로 모시겠습니다.', '벚꽃길가든입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:591', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('593', '충청남도 서산시 읍내1로 18 (읍내동)', '오시오', '오시오입니다. 좋은 서비스로 모시겠습니다.', '오시오입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:592', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('594', '충청남도 아산시 음봉면 음봉로681번길 24 상가동 207호 (초원(아))', '흥부네부대찌개', '흥부네부대찌개입니다. 좋은 서비스로 모시겠습니다.', '흥부네부대찌개입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:593', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('595', '충청남도 아산시 시민로 467-5 (온천동)', '풀향기', '풀향기입니다. 좋은 서비스로 모시겠습니다.', '풀향기입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:594', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('596', '충청남도 천안시 서북구 성정4길 36 (성정동)', '천안칼국수', '천안칼국수입니다. 좋은 서비스로 모시겠습니다.', '천안칼국수입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:595', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('597', '충청남도 천안시 서북구 봉정로 120-1 (성정동)', '그옛날통닭', '그옛날통닭입니다. 좋은 서비스로 모시겠습니다.', '그옛날통닭입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:596', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('598', '충청남도 천안시 동남구 성황로 75 (원성동)', '권구성순대국밥', '권구성순대국밥입니다. 좋은 서비스로 모시겠습니다.', '권구성순대국밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:597', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('599', '충청북도 진천군 진천읍 남산길 99', '사대부보쌈', '사대부보쌈입니다. 좋은 서비스로 모시겠습니다.', '사대부보쌈입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:598', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('600', '강원도 속초시 먹거리길 22 (교동)', '반올림피자샵속초점', '반올림피자샵속초점입니다. 좋은 서비스로 모시겠습니다.', '반올림피자샵속초점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:599', TRUE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('601', '강원도 속초시 만리공원길 7-1 (교동외1)', '동백연탄구이', '동백연탄구이입니다. 좋은 서비스로 모시겠습니다.', '동백연탄구이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:600', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('602', '강원도 원주시 천매봉길 139 (단구동)', '한우관', '한우관입니다. 좋은 서비스로 모시겠습니다.', '한우관입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:601', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('603', '강원도 원주시 송림길 48-23 (단구동)', '불꽃숯불구이', '불꽃숯불구이입니다. 좋은 서비스로 모시겠습니다.', '불꽃숯불구이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:602', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('604', '강원도 춘천시 남산면 강촌로 151-1 1층', '강촌찐해물칼국수', '강촌찐해물칼국수입니다. 좋은 서비스로 모시겠습니다.', '강촌찐해물칼국수입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:603', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('605', '경기도 남양주시 별내면 송산로 632', '고수', '고수입니다. 좋은 서비스로 모시겠습니다.', '고수입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:604', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('606', '경기도 고양시 일산서구 덕산로 196-3 (가좌동번지 1층(일부))', '두신마을', '두신마을입니다. 좋은 서비스로 모시겠습니다.', '두신마을입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:605', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('607', '경기도 안산시 단원구 선여불로 33 (선부동 1044-18  1층)', '뚱보생삼겹살', '뚱보생삼겹살입니다. 좋은 서비스로 모시겠습니다.', '뚱보생삼겹살입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:606', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('608', '경기도 평택시 평남로 281 (통복동삼성아파트상가109호)', '치킨마루서부역점', '치킨마루서부역점입니다. 좋은 서비스로 모시겠습니다.', '치킨마루서부역점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:607', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('609', '경기도 성남시 분당구 벌말로40번길 3 (야탑동 성산빌딩 1층 일부(101-1호))', '교촌치킨', '교촌치킨입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:608', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('610', '경기도 수원시 팔달구 동말로 42 (화서동)', '月(달월)', '月(달월)입니다. 좋은 서비스로 모시겠습니다.', '月(달월)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:609', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('611', '경기도 수원시 권선구 금호로15번길 15 (금곡동신미주상가115호)', '화통치킨', '화통치킨입니다. 좋은 서비스로 모시겠습니다.', '화통치킨입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:610', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('612', '울산광역시 울주군 상북면 등억알프스로 409', '반석촌', '반석촌입니다. 좋은 서비스로 모시겠습니다.', '반석촌입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:611', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('613', '울산광역시 북구 제내1길 14-1 (신천동(지상1층))', '자미식당', '자미식당입니다. 좋은 서비스로 모시겠습니다.', '자미식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:612', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('614', '울산광역시 북구 동대15길 19 (호계동)', '꿀꿀이석쇠숯불구이', '꿀꿀이석쇠숯불구이입니다. 좋은 서비스로 모시겠습니다.', '꿀꿀이석쇠숯불구이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:613', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('615', '울산광역시 남구 삼산로144번길 2 (달동번지)', '식껍울산점', '식껍울산점입니다. 좋은 서비스로 모시겠습니다.', '식껍울산점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:614', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('616', '울산광역시 남구 대학로43번길 6-3 1층 (무거동)', '남가네', '남가네입니다. 좋은 서비스로 모시겠습니다.', '남가네입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:615', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('617', '대전광역시 유성구 전민로70번길 62 지상1층 (전민동)', '아저씨', '아저씨입니다. 좋은 서비스로 모시겠습니다.', '아저씨입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:616', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('618', '대전광역시 유성구 은구비남로 5 지상1층 (지족동)', '다복이네국밥노은점', '다복이네국밥노은점입니다. 좋은 서비스로 모시겠습니다.', '다복이네국밥노은점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:617', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('619', '대전광역시 서구 장안로 632 (장안동)', '알프스펜션', '알프스펜션입니다. 좋은 서비스로 모시겠습니다.', '알프스펜션입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:618', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('620', '광주광역시 서구 내방로165번길 5 (쌍촌동(일층))', '대아도', '대아도입니다. 좋은 서비스로 모시겠습니다.', '대아도입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:619', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('621', '인천광역시 남동구 문화로89번길 48 2층 (구월동)', '꿀', '꿀입니다. 좋은 서비스로 모시겠습니다.', '꿀입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:620', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('622', '대구광역시 서구 달구벌대로361길 9 (내당동세신아파트상가3호)', '세끼중에한끼', '세끼중에한끼입니다. 좋은 서비스로 모시겠습니다.', '세끼중에한끼입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:621', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('623', '부산광역시 연제구 월드컵대로 171 (연산동)', '아지바라', '아지바라입니다. 좋은 서비스로 모시겠습니다.', '아지바라입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:622', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('624', '부산광역시 연제구 고분로235번길 8 (연산동)', '돈군', '돈군입니다. 좋은 서비스로 모시겠습니다.', '돈군입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:623', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('625', '부산광역시 금정구 동부곡로5번길 3 (부곡동)', '까투리', '까투리입니다. 좋은 서비스로 모시겠습니다.', '까투리입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:624', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('626', '부산광역시 사하구 낙동대로535번길 14 (하단동)', '더램(THE램)', '더램(THE램)입니다. 좋은 서비스로 모시겠습니다.', '더램(THE램)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:625', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('627', '부산광역시 부산진구 서면로 45 (부전동)', '메이즈펍(MAZE PUB)', '메이즈펍(MAZE PUB)입니다. 좋은 서비스로 모시겠습니다.', '메이즈펍(MAZE PUB)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:626', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('628', '서울특별시 강동구 명일로 171 (둔촌동)', '빠사시 둔촌점', '빠사시 둔촌점입니다. 좋은 서비스로 모시겠습니다.', '빠사시 둔촌점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:627', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('629', '서울특별시 강남구 봉은사로84길 34 지상1 2층 (삼성동)', '이자카야 한잔 삼성본점', '이자카야 한잔 삼성본점입니다. 좋은 서비스로 모시겠습니다.', '이자카야 한잔 삼성본점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:628', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('630', '서울특별시 금천구 시흥대로52길 46 지상1층 (시흥동)', '달봉비어', '달봉비어입니다. 좋은 서비스로 모시겠습니다.', '달봉비어입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:629', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('631', '서울특별시 강서구 강서로17길 36 (화곡동(지상 1층))', '레인호프', '레인호프입니다. 좋은 서비스로 모시겠습니다.', '레인호프입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:630', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('632', '서울특별시 서대문구 충정로 20 1층 (충정로3가)', '벙커원', '벙커원입니다. 좋은 서비스로 모시겠습니다.', '벙커원입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:631', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('633', '서울특별시 강북구 삼양로20길 21 (미아동)', '송천식당', '송천식당입니다. 좋은 서비스로 모시겠습니다.', '송천식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:632', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('634', '충청북도 청주시 상당구 낭성면 단재로 1619-30', '안인골', '안인골입니다. 좋은 서비스로 모시겠습니다.', '안인골입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:633', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('635', '경상남도 창원시 진해구 용재로3번길 4 (용원동)', '종가집돼지국밥', '종가집돼지국밥입니다. 좋은 서비스로 모시겠습니다.', '종가집돼지국밥입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:634', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('636', '경상남도 창원시 마산합포구 사궁두미길 92 (덕동동외1필지)', '아다지오', '아다지오입니다. 좋은 서비스로 모시겠습니다.', '아다지오입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:635', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('637', '경기도 포천시 중앙로 131 (신읍동)', '한스델리 포천점', '한스델리 포천점입니다. 좋은 서비스로 모시겠습니다.', '한스델리 포천점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:636', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('638', '경기도 화성시 남양읍 남양성지로 155 2동 1층 (남양동)', '맛나식당', '맛나식당입니다. 좋은 서비스로 모시겠습니다.', '맛나식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:637', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('639', '경상북도 영덕군 강구면 영덕대게로 325', '325 산곰장어', '325 산곰장어입니다. 좋은 서비스로 모시겠습니다.', '325 산곰장어입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:638', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('640', '경상북도 영주시 중앙로 64 (영주동(2층))', '와빠레스토랑', '와빠레스토랑입니다. 좋은 서비스로 모시겠습니다.', '와빠레스토랑입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:639', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('641', '경상북도 포항시 남구 대이로127번길 4 (이동)', '한씨네 메밀막국수', '한씨네 메밀막국수입니다. 좋은 서비스로 모시겠습니다.', '한씨네 메밀막국수입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:640', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('642', '경상북도 포항시 북구 흥해읍 흥해로 26', '아모르', '아모르입니다. 좋은 서비스로 모시겠습니다.', '아모르입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:641', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('643', '전라남도 목포시 입암천남로77번길 20 (산정동)', '명산숯불구이', '명산숯불구이입니다. 좋은 서비스로 모시겠습니다.', '명산숯불구이입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:642', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('644', '전라북도 익산시 목천로 281 전주소바 1층 (인화동2가)', '전주소바', '전주소바입니다. 좋은 서비스로 모시겠습니다.', '전주소바입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:643', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('645', '전라북도 군산시 신평안길 16-4 (지곡동)', '어청도', '어청도입니다. 좋은 서비스로 모시겠습니다.', '어청도입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:644', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('646', '충청남도 부여군 홍산면 홍산로 37', '대덕숯불갈비', '대덕숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '대덕숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:645', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('647', '충청남도 천안시 서북구 쌍용18길 7-1 (쌍용동)', '역전할머니맥주나사렛점', '역전할머니맥주나사렛점입니다. 좋은 서비스로 모시겠습니다.', '역전할머니맥주나사렛점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:646', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('648', '충청북도 제천시 용두대로 369 (신월동외2필지(1층))', '취란(제천점)', '취란(제천점)입니다. 좋은 서비스로 모시겠습니다.', '취란(제천점)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:647', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('649', '강원도 평창군 봉평면 태기로 104', '장금이감자탕(휘닉스점)', '장금이감자탕(휘닉스점)입니다. 좋은 서비스로 모시겠습니다.', '장금이감자탕(휘닉스점)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:648', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('650', '강원도 강릉시 주문진읍 항구로 57', '해물동네', '해물동네입니다. 좋은 서비스로 모시겠습니다.', '해물동네입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:649', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('651', '강원도 춘천시 동산면 종자리로 331-50', '광림공원(주)', '광림공원(주)입니다. 좋은 서비스로 모시겠습니다.', '광림공원(주)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:650', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('652', '경기도 안성시 공도읍 서동대로 4079 121호 (주은풍림아파트)', '박군치킨', '박군치킨입니다. 좋은 서비스로 모시겠습니다.', '박군치킨입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:651', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('653', '경기도 파주시 조리읍 등원로 13', '백암토종순대', '백암토종순대입니다. 좋은 서비스로 모시겠습니다.', '백암토종순대입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:652', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('654', '경기도 의왕시 월암길 61 (월암동)', '시골백반', '시골백반입니다. 좋은 서비스로 모시겠습니다.', '시골백반입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:653', FALSE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('655', '경기도 고양시 일산동구 무궁화로 42-38 (장항동번지 범진빌딩 1층(일)', '바지락손칼국수', '바지락손칼국수입니다. 좋은 서비스로 모시겠습니다.', '바지락손칼국수입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:654', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('656', '경기도 안산시 상록구 석호로 331 1층 (본오동)', '뚝심이감자탕', '뚝심이감자탕입니다. 좋은 서비스로 모시겠습니다.', '뚝심이감자탕입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:655', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('657', '경기도 광명시 오리로856번길 8-1 (철산동2층)', '설빙', '설빙입니다. 좋은 서비스로 모시겠습니다.', '설빙입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:656', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('658', '경기도 의정부시 동일로466번길 39 (신곡동외 1필지 지상1층)', '좋은 친구들', '좋은 친구들입니다. 좋은 서비스로 모시겠습니다.', '좋은 친구들입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:657', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('659', '경기도 수원시 팔달구 정조로 751-11 (중동)', '엘리웨이탭하우스', '엘리웨이탭하우스입니다. 좋은 서비스로 모시겠습니다.', '엘리웨이탭하우스입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:658', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('660', '울산광역시 울주군 온산읍 산암로 27', '한솔식당', '한솔식당입니다. 좋은 서비스로 모시겠습니다.', '한솔식당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:659', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('661', '광주광역시 북구 호동로 24 (중흥동)', '하카야', '하카야입니다. 좋은 서비스로 모시겠습니다.', '하카야입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:660', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('662', '광주광역시 남구 서문대로 737-2 (진월동(일층))', '소굴', '소굴입니다. 좋은 서비스로 모시겠습니다.', '소굴입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:661', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('663', '대구광역시 달서구 학산남로 6 (상인동(지상1층))', '안동뒷고기', '안동뒷고기입니다. 좋은 서비스로 모시겠습니다.', '안동뒷고기입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:662', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('664', '대구광역시 달서구 학산남로 6 (상인동(지상1층))', '선산곱창', '선산곱창입니다. 좋은 서비스로 모시겠습니다.', '선산곱창입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:663', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('665', '대구광역시 달서구 선원로 273 1층 (용산동)', '동궁찜닭(용산점)', '동궁찜닭(용산점)입니다. 좋은 서비스로 모시겠습니다.', '동궁찜닭(용산점)입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:664', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('666', '부산광역시 사상구 대동로 91-3 (학장동)', '맥주마당', '맥주마당입니다. 좋은 서비스로 모시겠습니다.', '맥주마당입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:665', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('667', '부산광역시 사하구 괴정로 247 (괴정동)', '탐나네녹돈', '탐나네녹돈입니다. 좋은 서비스로 모시겠습니다.', '탐나네녹돈입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:666', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('668', '부산광역시 해운대구 좌동순환로 77 (좌동 지상1층 일부)', '그린하노이 좌동점', '그린하노이 좌동점입니다. 좋은 서비스로 모시겠습니다.', '그린하노이 좌동점입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:667', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('669', '부산광역시 서구 대청로6번길 30 (토성동3가)', '짬뽕의신', '짬뽕의신입니다. 좋은 서비스로 모시겠습니다.', '짬뽕의신입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:668', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('670', '부산광역시 중구 광복로97번안길 12 (광복동1가)', '다주리', '다주리입니다. 좋은 서비스로 모시겠습니다.', '다주리입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:669', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('671', '서울특별시 강동구 천호대로155길 15 1층 (천호동)', '오가네', '오가네입니다. 좋은 서비스로 모시겠습니다.', '오가네입니다. 좋은 서비스로 모시겠습니다.', '중국산', '10:00 - 22:670', FALSE, FALSE, FALSE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('672', '서울특별시 송파구 송파대로30길 11 지상1층 (가락동)', '가장 맛있는 족발', '가장 맛있는 족발입니다. 좋은 서비스로 모시겠습니다.', '가장 맛있는 족발입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:671', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('673', '서울특별시 강남구 언주로85길 13 (역삼동경남아파트상가지상1층111호)', '킹콩생고기', '킹콩생고기입니다. 좋은 서비스로 모시겠습니다.', '킹콩생고기입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:672', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('674', '서울특별시 관악구 신림로32길 7 (신림동지상1층)', '소문난생오리돌구이', '소문난생오리돌구이입니다. 좋은 서비스로 모시겠습니다.', '소문난생오리돌구이입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:673', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('675', '서울특별시 마포구 망원로 21 (망원동1층)', '이디야', '이디야입니다. 좋은 서비스로 모시겠습니다.', '이디야입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:674', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('676', '서울특별시 노원구 동일로 1362 115호 (상계동 주공4단지상가)', '본죽(상계백병원점)', '본죽(상계백병원점)입니다. 좋은 서비스로 모시겠습니다.', '본죽(상계백병원점)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:675', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('677', '서울특별시 노원구 덕릉로 669 세양빌딩 1층 103호 (중계동)', 'B.H.C.치킨 중계본점', 'B.H.C.치킨 중계본점입니다. 좋은 서비스로 모시겠습니다.', 'B.H.C.치킨 중계본점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:676', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('678', '서울특별시 강북구 도봉로49길 7 (미아동(밤꽃3길 5)(지상1층))', '기품', '기품입니다. 좋은 서비스로 모시겠습니다.', '기품입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:677', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('679', '서울특별시 성동구 마조로3가길 27 (행당동(지상2층))', '천국', '천국입니다. 좋은 서비스로 모시겠습니다.', '천국입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:678', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('680', '서울특별시 성동구 마조로3가길 27 (행당동(지상1층))', '서울왕족발', '서울왕족발입니다. 좋은 서비스로 모시겠습니다.', '서울왕족발입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:679', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('681', '서울특별시 중구 장충단로13길 7 (을지로6가(2층))', 'Seattle(시애틀)', 'Seattle(시애틀)입니다. 좋은 서비스로 모시겠습니다.', 'Seattle(시애틀)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:680', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('682', '경상남도 창원시 마산합포구 합포로 135 (산호동)', '생방송', '생방송입니다. 좋은 서비스로 모시겠습니다.', '생방송입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:681', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('683', '경상남도 창원시 마산회원구 내서읍 광려로 330-17', '건강하새우', '건강하새우입니다. 좋은 서비스로 모시겠습니다.', '건강하새우입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:682', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('684', '경상남도 진주시 신평공원길87번길 2 (신안동1층일부)', '인디애나숯불치킨', '인디애나숯불치킨입니다. 좋은 서비스로 모시겠습니다.', '인디애나숯불치킨입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:683', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('685', '경상북도 영덕군 축산면 신돌석장군2길 27-1', '예이제', '예이제입니다. 좋은 서비스로 모시겠습니다.', '예이제입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:684', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('686', '경상북도 안동시 복주1길 77 1층 (옥동)', '지직스1', '지직스1입니다. 좋은 서비스로 모시겠습니다.', '지직스1입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:685', FALSE, FALSE, TRUE, FALSE, TRUE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('687', '경상북도 포항시 북구 흥해읍 동해대로 1562', '투다리흥해마산점', '투다리흥해마산점입니다. 좋은 서비스로 모시겠습니다.', '투다리흥해마산점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:686', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('688', '경상북도 포항시 남구 대이로189번길 12 1층 (이동)', '산너머남촌', '산너머남촌입니다. 좋은 서비스로 모시겠습니다.', '산너머남촌입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:687', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('689', '전라남도 여수시 여문문화1길 80 1층 (여서동)', '일송정', '일송정입니다. 좋은 서비스로 모시겠습니다.', '일송정입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:688', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('690', '충청남도 홍성군 금마면 충서로 1900', '꼬불간 또오기', '꼬불간 또오기입니다. 좋은 서비스로 모시겠습니다.', '꼬불간 또오기입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:689', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('691', '충청북도 음성군 삼성면 범말길 49 (외 39필지)', '썬밸리CC<컨트리클럽>', '썬밸리CC<컨트리클럽>입니다. 좋은 서비스로 모시겠습니다.', '썬밸리CC<컨트리클럽>입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:690', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('692', '충청북도 진천군 진천읍 남산8길 10-2', '백경', '백경입니다. 좋은 서비스로 모시겠습니다.', '백경입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:691', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('693', '충청북도 충주시 산척면 동산로 688-1', '모퉁이카페', '모퉁이카페입니다. 좋은 서비스로 모시겠습니다.', '모퉁이카페입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:692', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('694', '경기도 안성시 양성면 옥단길 13-2', '가보한방오리백숙', '가보한방오리백숙입니다. 좋은 서비스로 모시겠습니다.', '가보한방오리백숙입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:693', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('695', '경기도 용인시 처인구 원삼면 고당로 21', '예전통닭.치킨.피자', '예전통닭.치킨.피자입니다. 좋은 서비스로 모시겠습니다.', '예전통닭.치킨.피자입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:694', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('696', '경기도 시흥시 인선길 46 121호 (장곡동)', '도리돈까스장곡점', '도리돈까스장곡점입니다. 좋은 서비스로 모시겠습니다.', '도리돈까스장곡점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:695', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('697', '경기도 남양주시 별내면 청학로68번길 5-23', '신의주순대와쭈꾸미청학점', '신의주순대와쭈꾸미청학점입니다. 좋은 서비스로 모시겠습니다.', '신의주순대와쭈꾸미청학점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:696', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('698', '경기도 남양주시 별내면 청학로68번길 5-23', '도감마을', '도감마을입니다. 좋은 서비스로 모시겠습니다.', '도감마을입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:697', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('699', '경기도 고양시 덕양구 무원로36번길 15-2 (행신동1층)', '향원', '향원입니다. 좋은 서비스로 모시겠습니다.', '향원입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:698', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('700', '경기도 고양시 일산서구 중앙로 1493 1068호 (주엽동 문촌마을복합상가)', '교촌치킨(주엽점)', '교촌치킨(주엽점)입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨(주엽점)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:699', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('701', '경기도 평택시 자유로3번길 14 (평택동)', '노천드럼통평택점', '노천드럼통평택점입니다. 좋은 서비스로 모시겠습니다.', '노천드럼통평택점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:700', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('702', '경기도 평택시 안중읍 안현로서6길 32 103104호', '교촌치킨안중1호점', '교촌치킨안중1호점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨안중1호점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:701', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('703', '경기도 수원시 영통구 봉영로1759번길 11 (영통동)', '영통청기와감자탕', '영통청기와감자탕입니다. 좋은 서비스로 모시겠습니다.', '영통청기와감자탕입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:702', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('704', '울산광역시 남구 왕생로168번길 21-1 (삼산동(지상1층))', '정원', '정원입니다. 좋은 서비스로 모시겠습니다.', '정원입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:703', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('705', '대전광역시 서구 탄방로7번길 71 (탄방동(3층))', '양수리', '양수리입니다. 좋은 서비스로 모시겠습니다.', '양수리입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:704', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('706', '광주광역시 서구 상무연하로 63 7층 (치평동)', '더 Bar', '더 Bar입니다. 좋은 서비스로 모시겠습니다.', '더 Bar입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:705', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('707', '부산광역시 중구 비프광장로 11 (부평동1가)', '꼬마김밥', '꼬마김밥입니다. 좋은 서비스로 모시겠습니다.', '꼬마김밥입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:706', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('708', '서울특별시 송파구 올림픽로8길 12 지상 2층 (잠실동)', '화담 신천점', '화담 신천점입니다. 좋은 서비스로 모시겠습니다.', '화담 신천점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:707', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('709', '서울특별시 영등포구 디지털로 382-1 (대림동)', '지성', '지성입니다. 좋은 서비스로 모시겠습니다.', '지성입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:708', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('710', '서울특별시 노원구 한글비석로 269 201호 (중계동 마들프라자)', '포메인', '포메인입니다. 좋은 서비스로 모시겠습니다.', '포메인입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:709', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('711', '서울특별시 중구 퇴계로 386 (신당동(1층))', '삼대 나주곰탕', '삼대 나주곰탕입니다. 좋은 서비스로 모시겠습니다.', '삼대 나주곰탕입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:710', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('712', '충청북도 청주시 흥덕구 흥덕로161번길 4 (운천동(1층))', '주천식당', '주천식당입니다. 좋은 서비스로 모시겠습니다.', '주천식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:711', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('713', '충청남도 당진시 합덕읍 버그내2길 181', '본가갈비', '본가갈비입니다. 좋은 서비스로 모시겠습니다.', '본가갈비입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:712', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('714', '충청남도 계룡시 엄사면 번영2길 4-85', '언제나돼지', '언제나돼지입니다. 좋은 서비스로 모시겠습니다.', '언제나돼지입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:713', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('715', '경상남도 남해군 남면 남면로 175', '해월정횟집', '해월정횟집입니다. 좋은 서비스로 모시겠습니다.', '해월정횟집입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:714', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('716', '경상남도 진주시 망경로 231 (망경동(1층일부))', '으랏차차', '으랏차차입니다. 좋은 서비스로 모시겠습니다.', '으랏차차입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:715', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('717', '경상남도 진주시 금산면 금산로 198 (번지)', '땡기네칼국수', '땡기네칼국수입니다. 좋은 서비스로 모시겠습니다.', '땡기네칼국수입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:716', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('718', '경상북도 칠곡군 석적읍 북중리12길 1', '녹꾸잇', '녹꾸잇입니다. 좋은 서비스로 모시겠습니다.', '녹꾸잇입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:717', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('719', '경상북도 성주군 성주읍 성주순환로 242', '연잎가마솥왕족발', '연잎가마솥왕족발입니다. 좋은 서비스로 모시겠습니다.', '연잎가마솥왕족발입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:718', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('720', '경상북도 의성군 봉양면 도리원3길 2', '한잔비어', '한잔비어입니다. 좋은 서비스로 모시겠습니다.', '한잔비어입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:719', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('721', '경상북도 안동시 옥동2길 41-12 (옥동)', '연식당', '연식당입니다. 좋은 서비스로 모시겠습니다.', '연식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:720', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('722', '경상북도 경주시 금성로372번길 20 (성건동)', '우야꼬', '우야꼬입니다. 좋은 서비스로 모시겠습니다.', '우야꼬입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:721', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('723', '경상북도 경주시 안강읍 구부랑4길 14', '비에이치씨치킨경주안강점', '비에이치씨치킨경주안강점입니다. 좋은 서비스로 모시겠습니다.', '비에이치씨치킨경주안강점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:722', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('724', '경상북도 경주시 봉황로51번길 3 (노서동)', '베누스', '베누스입니다. 좋은 서비스로 모시겠습니다.', '베누스입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:723', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('725', '전라남도 장성군 동화면 삼동로 713', '동화갈비', '동화갈비입니다. 좋은 서비스로 모시겠습니다.', '동화갈비입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:724', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('726', '전라남도 순천시 왕궁길 16 (조례동(1층))', '금탑소머리국밥', '금탑소머리국밥입니다. 좋은 서비스로 모시겠습니다.', '금탑소머리국밥입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:725', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('727', '전라남도 여수시 여서1로 87 (여서동)', '파스쿠찌', '파스쿠찌입니다. 좋은 서비스로 모시겠습니다.', '파스쿠찌입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:726', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('728', '전라북도 군산시 칠성로 193 (소룡동)', '소하정(SohaJung)', '소하정(SohaJung)입니다. 좋은 서비스로 모시겠습니다.', '소하정(SohaJung)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:727', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('729', '전라북도 군산시 하나운3길 14 (나운동)', '920(구이공)', '920(구이공)입니다. 좋은 서비스로 모시겠습니다.', '920(구이공)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:728', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('730', '전라북도 전주시 덕진구 태진로 137-3 (금암동)', '임실식당', '임실식당입니다. 좋은 서비스로 모시겠습니다.', '임실식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:729', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('731', '전라북도 전주시 덕진구 떡전4길 22-2 (금암동외2필지)', '로메인', '로메인입니다. 좋은 서비스로 모시겠습니다.', '로메인입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:730', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('732', '충청남도 청양군 청양읍 칠갑산로4길 26', '바다양푼이동태탕&별미바지락칼국수', '바다양푼이동태탕&별미바지락칼국수입니다. 좋은 서비스로 모시겠습니다.', '바다양푼이동태탕&별미바지락칼국수입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:731', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('733', '충청남도 서산시 한마음15로 78 1층 (동문동)', '소담', '소담입니다. 좋은 서비스로 모시겠습니다.', '소담입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:732', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('734', '충청남도 천안시 서북구 봉정로 386 (두정동103호)', '투다리체인점', '투다리체인점입니다. 좋은 서비스로 모시겠습니다.', '투다리체인점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:733', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('735', '충청남도 천안시 동남구 수신면 수신로 557', '천안상록씨씨점동6그늘집', '천안상록씨씨점동6그늘집입니다. 좋은 서비스로 모시겠습니다.', '천안상록씨씨점동6그늘집입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:734', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('736', '충청남도 천안시 동남구 수신면 수신로 557', '천안상록씨씨점남1스타트하우스', '천안상록씨씨점남1스타트하우스입니다. 좋은 서비스로 모시겠습니다.', '천안상록씨씨점남1스타트하우스입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:735', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('737', '강원도 평창군 봉평면 태기로 320', '산채랑황태랑', '산채랑황태랑입니다. 좋은 서비스로 모시겠습니다.', '산채랑황태랑입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:736', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('738', '강원도 속초시 먹거리1길 8 (교동)', '수산시장회포장배달', '수산시장회포장배달입니다. 좋은 서비스로 모시겠습니다.', '수산시장회포장배달입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:737', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('739', '강원도 춘천시 퇴계로145번길 7-1 (퇴계동)', '간이역주공점', '간이역주공점입니다. 좋은 서비스로 모시겠습니다.', '간이역주공점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:738', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('740', '경기도 용인시 기흥구 마북로 116 (마북동)', '울림', '울림입니다. 좋은 서비스로 모시겠습니다.', '울림입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:739', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('741', '경기도 용인시 처인구 고림로 81 (고림동지하1층)', '용인서울병원장례식장', '용인서울병원장례식장입니다. 좋은 서비스로 모시겠습니다.', '용인서울병원장례식장입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:740', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('742', '경기도 용인시 기흥구 마북로 119-16 (마북동)', '산고을오리', '산고을오리입니다. 좋은 서비스로 모시겠습니다.', '산고을오리입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:741', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('743', '경기도 부천시 부천로 124 1층 67호 (원미동)', '투다리(복돼지점)', '투다리(복돼지점)입니다. 좋은 서비스로 모시겠습니다.', '투다리(복돼지점)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:742', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('744', '경기도 부천시 소사로793번길 9 (원종동 성진그린타운 3동 101호)', '착한초밥', '착한초밥입니다. 좋은 서비스로 모시겠습니다.', '착한초밥입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:743', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('745', '경기도 부천시 경인옛로 30 (소사본동)', '신의주찹쌀순대', '신의주찹쌀순대입니다. 좋은 서비스로 모시겠습니다.', '신의주찹쌀순대입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:744', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('746', '경기도 안양시 동안구 갈산로2번길 43 (호계동 1층)', '옛고을', '옛고을입니다. 좋은 서비스로 모시겠습니다.', '옛고을입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:745', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('747', '경기도 의정부시 추동로 43 115호 (신곡동 극동동성아파트 상가)', '피자스쿨', '피자스쿨입니다. 좋은 서비스로 모시겠습니다.', '피자스쿨입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:746', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('748', '경기도 수원시 권선구 서부로1538번길 33 (고색동)', '양지식당', '양지식당입니다. 좋은 서비스로 모시겠습니다.', '양지식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:747', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('749', '경기도 수원시 영통구 태장로 62 105호 (망포동 신영통 동원프라자)', '비에이치씨(BHC) 신영통점', '비에이치씨(BHC) 신영통점입니다. 좋은 서비스로 모시겠습니다.', '비에이치씨(BHC) 신영통점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:748', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('750', '울산광역시 남구 돋질로384번길 10 (삼산동)', '삼산칼국수', '삼산칼국수입니다. 좋은 서비스로 모시겠습니다.', '삼산칼국수입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:749', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('751', '대전광역시 서구 둔산중로 138 (둔산동주은오피스텔 207208호)', '바우네 나주곰탕', '바우네 나주곰탕입니다. 좋은 서비스로 모시겠습니다.', '바우네 나주곰탕입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:750', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('752', '대전광역시 중구 과례로39번길 16 2층 (문화동)', '웰빙가든흑염소요리전문', '웰빙가든흑염소요리전문입니다. 좋은 서비스로 모시겠습니다.', '웰빙가든흑염소요리전문입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:751', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('753', '대전광역시 중구 대흥로121번길 43 1~2층 (대흥동)', '바다황제', '바다황제입니다. 좋은 서비스로 모시겠습니다.', '바다황제입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:752', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('754', '대전광역시 중구 보문산공원로 535 (대사동(1층))', '녹두빈대떡', '녹두빈대떡입니다. 좋은 서비스로 모시겠습니다.', '녹두빈대떡입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:753', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('755', '인천광역시 계양구 봉오대로698번길 17-1 (작전동1층)', '엄마손두부마을', '엄마손두부마을입니다. 좋은 서비스로 모시겠습니다.', '엄마손두부마을입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:754', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('756', '인천광역시 계양구 도두리로 33 (계산동상산빌딩 101호)', '까치전포차', '까치전포차입니다. 좋은 서비스로 모시겠습니다.', '까치전포차입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:755', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('757', '인천광역시 부평구 열우물로25번길 6 (십정동)', '유진물텀벙', '유진물텀벙입니다. 좋은 서비스로 모시겠습니다.', '유진물텀벙입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:756', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('758', '인천광역시 부평구 마장로 489 (청천동(아이즈빌아울렛 2133호))', '멘무샤', '멘무샤입니다. 좋은 서비스로 모시겠습니다.', '멘무샤입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:757', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('759', '인천광역시 부평구 마장로 325-2 (산곡동)', '김밥천국', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:758', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('760', '인천광역시 남동구 구월말로 65 1층 (만수동)', '우돈가', '우돈가입니다. 좋은 서비스로 모시겠습니다.', '우돈가입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:759', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('761', '대구광역시 달서구 달구벌대로344길 15 (두류동)', '참한집', '참한집입니다. 좋은 서비스로 모시겠습니다.', '참한집입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:760', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('762', '대구광역시 달서구 월곡로 144 1층 (상인동)', '참치명가', '참치명가입니다. 좋은 서비스로 모시겠습니다.', '참치명가입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:761', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('763', '대구광역시 달서구 학산로 230 (송현동)', '윙크', '윙크입니다. 좋은 서비스로 모시겠습니다.', '윙크입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:762', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('764', '대구광역시 달서구 서당로9길 9 (신당동)', '엠쓰리푸드', '엠쓰리푸드입니다. 좋은 서비스로 모시겠습니다.', '엠쓰리푸드입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:763', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('765', '대구광역시 수성구 상록로16길 10 (범어동)', '킴스', '킴스입니다. 좋은 서비스로 모시겠습니다.', '킴스입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:764', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('766', '대구광역시 수성구 수성못2길 43 (두산동)', '박창우의소백산왕소금구이수성못점', '박창우의소백산왕소금구이수성못점입니다. 좋은 서비스로 모시겠습니다.', '박창우의소백산왕소금구이수성못점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:765', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('767', '대구광역시 북구 신천동로 734 (대현동)', '향미반점', '향미반점입니다. 좋은 서비스로 모시겠습니다.', '향미반점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:766', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('768', '대구광역시 북구 구암로 288-1 (구암동)', '함지생고기', '함지생고기입니다. 좋은 서비스로 모시겠습니다.', '함지생고기입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:767', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('769', '대구광역시 북구 칠곡중앙대로65길 21 (태전동)', '역전할머니보건대점', '역전할머니보건대점입니다. 좋은 서비스로 모시겠습니다.', '역전할머니보건대점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:768', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('770', '대구광역시 서구 문화로 316 (비산동)', '대박수산', '대박수산입니다. 좋은 서비스로 모시겠습니다.', '대박수산입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:769', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('771', '부산광역시 금정구 금강로 571-30 (구서동)', '김밥천국두실점', '김밥천국두실점입니다. 좋은 서비스로 모시겠습니다.', '김밥천국두실점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:770', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('772', '부산광역시 해운대구 좌동순환로468번길 71-14 (중동 에이동비이동(지상1층))', '삼보원', '삼보원입니다. 좋은 서비스로 모시겠습니다.', '삼보원입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:771', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('773', '부산광역시 남구 수영로322번길 21 (대연동)', '더블린 기네스', '더블린 기네스입니다. 좋은 서비스로 모시겠습니다.', '더블린 기네스입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:772', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('774', '부산광역시 영도구 남항로31번길 36 (남항동1가)', '백년족발', '백년족발입니다. 좋은 서비스로 모시겠습니다.', '백년족발입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:773', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('775', '부산광역시 서구 엄광산로 36 (서대신동3가)', '잠이손두부', '잠이손두부입니다. 좋은 서비스로 모시겠습니다.', '잠이손두부입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:774', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('776', '서울특별시 강남구 역삼로64길 11 (대치동지상1층)', '페리카나', '페리카나입니다. 좋은 서비스로 모시겠습니다.', '페리카나입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:775', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('777', '서울특별시 강남구 삼성로81길 35 (대치동)', '우밀가', '우밀가입니다. 좋은 서비스로 모시겠습니다.', '우밀가입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:776', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('778', '서울특별시 강남구 역삼로 419 (대치동지상1층)', '모리향', '모리향입니다. 좋은 서비스로 모시겠습니다.', '모리향입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:777', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('779', '서울특별시 강남구 밤고개로1길 10 (수서동현대하이엘지상1층17-8호)', '김밥천국', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '김밥천국입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:778', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('780', '서울특별시 서대문구 북아현로 54 (북아현동(지상1층))', '초밥사랑', '초밥사랑입니다. 좋은 서비스로 모시겠습니다.', '초밥사랑입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:779', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('781', '서울특별시 중랑구 사가정로 386 (면목동)', '콩심 사가정역점', '콩심 사가정역점입니다. 좋은 서비스로 모시겠습니다.', '콩심 사가정역점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:780', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('782', '서울특별시 종로구 대학로9길 23-2 (명륜4가)', '쿠바', '쿠바입니다. 좋은 서비스로 모시겠습니다.', '쿠바입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:781', FALSE, FALSE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('783', '제주특별자치도 제주시 진군중길 16 (노형동)', '웅지', '웅지입니다. 좋은 서비스로 모시겠습니다.', '웅지입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:782', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('784', '충청북도 청주시 상당구 원봉로 88-1 (용암동)', '나주홍어전문점', '나주홍어전문점입니다. 좋은 서비스로 모시겠습니다.', '나주홍어전문점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:783', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('785', '경상남도 창원시 성산구 마디미로64번길 1 미광빌딩 2층 202호 (상남동)', '본참치', '본참치입니다. 좋은 서비스로 모시겠습니다.', '본참치입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:784', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('786', '경기도 화성시 병점서로 33 1층 105호 (병점동  두산탑프라자105호)', '김인수 발아현미김밥', '김인수 발아현미김밥입니다. 좋은 서비스로 모시겠습니다.', '김인수 발아현미김밥입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:785', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('787', '경상남도 고성군 동해면 장기3길 110', '짜작이네', '짜작이네입니다. 좋은 서비스로 모시겠습니다.', '짜작이네입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:786', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('788', '경상남도 거제시 장평3로7길 38 (장평동(1층))', '남원추어탕', '남원추어탕입니다. 좋은 서비스로 모시겠습니다.', '남원추어탕입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:787', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('789', '경상북도 구미시 산동면 동백로 8 1동 1층', '나는조선의국밥이다', '나는조선의국밥이다입니다. 좋은 서비스로 모시겠습니다.', '나는조선의국밥이다입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:788', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('790', '경상북도 포항시 북구 창흥로 40 (창포동(1층))', '간이역(동양점)', '간이역(동양점)입니다. 좋은 서비스로 모시겠습니다.', '간이역(동양점)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:789', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('791', '전라남도 여수시 웅천로 348 (웅천동)', '피플', '피플입니다. 좋은 서비스로 모시겠습니다.', '피플입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:790', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('792', '전라남도 여수시 여문문화2길 15 (문수동)', '돈쌈', '돈쌈입니다. 좋은 서비스로 모시겠습니다.', '돈쌈입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:791', FALSE, TRUE, TRUE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('793', '전라남도 목포시 용당로196번길 9 2층 (용당동)', '아카데미먹거리', '아카데미먹거리입니다. 좋은 서비스로 모시겠습니다.', '아카데미먹거리입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:792', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('794', '전라북도 익산시 하나로11길 36-7 (영등동)', '와이', '와이입니다. 좋은 서비스로 모시겠습니다.', '와이입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:793', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('795', '전라북도 군산시 동팔마길 48 (대명동)', '똑순이따봉', '똑순이따봉입니다. 좋은 서비스로 모시겠습니다.', '똑순이따봉입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:794', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('796', '전라북도 전주시 완산구 안터6길 33 (서신동)', '돼지막(서신점)', '돼지막(서신점)입니다. 좋은 서비스로 모시겠습니다.', '돼지막(서신점)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:795', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('797', '충청남도 금산군 금산읍 비호로 88', '금산자연순대', '금산자연순대입니다. 좋은 서비스로 모시겠습니다.', '금산자연순대입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:796', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('798', '충청남도 천안시 서북구 성정중7길 34 (성정동)', '바비', '바비입니다. 좋은 서비스로 모시겠습니다.', '바비입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:797', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('799', '충청북도 음성군 금왕읍 금석로 83', '선유관', '선유관입니다. 좋은 서비스로 모시겠습니다.', '선유관입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:798', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('800', '충청북도 음성군 삼성면 청용로209번길 51', '상곡낚시터가든', '상곡낚시터가든입니다. 좋은 서비스로 모시겠습니다.', '상곡낚시터가든입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:799', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('801', '충청북도 충주시 칠금16길 2 (칠금동)', '조은날', '조은날입니다. 좋은 서비스로 모시겠습니다.', '조은날입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:800', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('802', '강원도 춘천시 춘주로 186 (퇴계동)', '황금돼지저금통', '황금돼지저금통입니다. 좋은 서비스로 모시겠습니다.', '황금돼지저금통입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:801', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('803', '경기도 안성시 일죽면 서동대로 7866', '동일죽장례식장', '동일죽장례식장입니다. 좋은 서비스로 모시겠습니다.', '동일죽장례식장입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:802', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('804', '경기도 이천시 부발읍 경충대로 2212 107호', '닭발천하', '닭발천하입니다. 좋은 서비스로 모시겠습니다.', '닭발천하입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:803', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('805', '경기도 용인시 처인구 백암면 청강가창로 5', '푸짐한자매밥집', '푸짐한자매밥집입니다. 좋은 서비스로 모시겠습니다.', '푸짐한자매밥집입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:804', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('806', '경기도 안산시 단원구 도일로 103 (신길동 지하 1층 일부(117118호))', '유림호프커피', '유림호프커피입니다. 좋은 서비스로 모시겠습니다.', '유림호프커피입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:805', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('807', '경기도 안산시 단원구 광덕동로 78 (고잔동 767  네오빌 6단지상가 104호)', '네오빌김밥', '네오빌김밥입니다. 좋은 서비스로 모시겠습니다.', '네오빌김밥입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:806', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('808', '경기도 의정부시 장금로78번길 55 A동 1층 (신곡동)', '김경자소문난대구왕뽈찜', '김경자소문난대구왕뽈찜입니다. 좋은 서비스로 모시겠습니다.', '김경자소문난대구왕뽈찜입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:807', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('809', '경기도 성남시 중원구 성남대로1140번길 10 2층 (성남동)', '전성루훠궈(全盛樓火鍋)', '전성루훠궈(全盛樓火鍋)입니다. 좋은 서비스로 모시겠습니다.', '전성루훠궈(全盛樓火鍋)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:808', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('810', '경기도 성남시 수정구 수정로136번길 6 1층 (수진동)', '매하꼬치', '매하꼬치입니다. 좋은 서비스로 모시겠습니다.', '매하꼬치입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:809', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('811', '울산광역시 북구 양정6길 26-3 (양정동)', '땅땅치킨(울산양정점)', '땅땅치킨(울산양정점)입니다. 좋은 서비스로 모시겠습니다.', '땅땅치킨(울산양정점)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:810', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('812', '울산광역시 남구 신정로37번길 35 (달동(지상1층))', '향촌', '향촌입니다. 좋은 서비스로 모시겠습니다.', '향촌입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:811', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('813', '울산광역시 중구 화진길 11 (태화동)', '해성식당', '해성식당입니다. 좋은 서비스로 모시겠습니다.', '해성식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:812', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('814', '대전광역시 유성구 온천서로 22-12 (봉명동2층)', '아인식당', '아인식당입니다. 좋은 서비스로 모시겠습니다.', '아인식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:813', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('815', '대전광역시 유성구 온천서로 22-12 지상1층 (봉명동)', '맹구네', '맹구네입니다. 좋은 서비스로 모시겠습니다.', '맹구네입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:814', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('816', '대전광역시 서구 동서대로 973-1 (내동(1층))', '해물천하', '해물천하입니다. 좋은 서비스로 모시겠습니다.', '해물천하입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:815', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('817', '대전광역시 서구 갈마로261번길 29 1층 (괴정동)', '먹자방', '먹자방입니다. 좋은 서비스로 모시겠습니다.', '먹자방입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:816', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('818', '대전광역시 동구 백룡로27번길 5 (자양동)', '청풍맛집', '청풍맛집입니다. 좋은 서비스로 모시겠습니다.', '청풍맛집입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:817', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('819', '광주광역시 북구 면앙로6번길 76 (용봉동2층)', '벌툰전남대점', '벌툰전남대점입니다. 좋은 서비스로 모시겠습니다.', '벌툰전남대점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:818', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('820', '광주광역시 북구 설죽로370번길 14 (오치동)', '까투리', '까투리입니다. 좋은 서비스로 모시겠습니다.', '까투리입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:819', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('821', '광주광역시 서구 염화로115번길 1 (화정동(일층))', '임실 엔 치즈피자', '임실 엔 치즈피자입니다. 좋은 서비스로 모시겠습니다.', '임실 엔 치즈피자입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:820', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('822', '광주광역시 서구 염화로 103 1층 (화정동)', '김밥나라', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '김밥나라입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:821', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('823', '인천광역시 서구 검단로459번길 7-3 (왕길동아트빌 108 109호)', '신마포갈매기검단점', '신마포갈매기검단점입니다. 좋은 서비스로 모시겠습니다.', '신마포갈매기검단점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:822', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('824', '인천광역시 서구 율도로77번길 6-1 (신현동)', '꼬꼬얼큰이 닭발', '꼬꼬얼큰이 닭발입니다. 좋은 서비스로 모시겠습니다.', '꼬꼬얼큰이 닭발입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:823', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('825', '인천광역시 서구 검단로459번길 7-3 (왕길동인천아트빌106.7)', '교촌치킨 검단1호점', '교촌치킨 검단1호점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨 검단1호점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:824', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('826', '인천광역시 미추홀구 토금중로 23 (용현동)', '버글버글', '버글버글입니다. 좋은 서비스로 모시겠습니다.', '버글버글입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:825', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('827', '대구광역시 달서구 상인로26길 10 (상인동)', '엠트리(Mtree)', '엠트리(Mtree)입니다. 좋은 서비스로 모시겠습니다.', '엠트리(Mtree)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:826', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('828', '대구광역시 달서구 구마로14남길 34 C동D동 지상1층 (본동)', '불난한우앤무한장어', '불난한우앤무한장어입니다. 좋은 서비스로 모시겠습니다.', '불난한우앤무한장어입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:827', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('829', '대구광역시 북구 매전로4길 10-10 (매천동)', '비비큐(매천 태전점)', '비비큐(매천 태전점)입니다. 좋은 서비스로 모시겠습니다.', '비비큐(매천 태전점)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:828', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('830', '대구광역시 중구 중앙대로61길 31 (남산동)', '장원식당', '장원식당입니다. 좋은 서비스로 모시겠습니다.', '장원식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:829', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('831', '부산광역시 북구 금곡대로285번길 19 (화명동리버사이드빌딩 2층203호)', '까페리아', '까페리아입니다. 좋은 서비스로 모시겠습니다.', '까페리아입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:830', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('832', '부산광역시 부산진구 가야대로 467 (개금동)', '도미노피자 부산개금점', '도미노피자 부산개금점입니다. 좋은 서비스로 모시겠습니다.', '도미노피자 부산개금점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:831', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('833', '부산광역시 중구 보수대로24번길 7 1층 (부평동2가 1층일부)', '양식당', '양식당입니다. 좋은 서비스로 모시겠습니다.', '양식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:832', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('834', '서울특별시 강남구 봉은사로108길 3-6 (삼성동지상1층)', '보리밀', '보리밀입니다. 좋은 서비스로 모시겠습니다.', '보리밀입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:833', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('835', '서울특별시 관악구 남현길 84 (남현동)', '여수식당', '여수식당입니다. 좋은 서비스로 모시겠습니다.', '여수식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:834', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('836', '서울특별시 구로구 디지털로32나길 15 (구로동)', '전봇대 오뎅', '전봇대 오뎅입니다. 좋은 서비스로 모시겠습니다.', '전봇대 오뎅입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:835', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('837', '서울특별시 강북구 노해로 99-1 (수유동(쌍문동길 103)(지상1층))', '돈초우', '돈초우입니다. 좋은 서비스로 모시겠습니다.', '돈초우입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:836', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('838', '서울특별시 성북구 성북로 18-1 (성북동)', '치킨마루', '치킨마루입니다. 좋은 서비스로 모시겠습니다.', '치킨마루입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:837', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('839', '서울특별시 성북구 한천로101길 59 (장위동)', '스넥코너', '스넥코너입니다. 좋은 서비스로 모시겠습니다.', '스넥코너입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:838', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('840', '서울특별시 성북구 보국문로 167 (정릉동 산장상가8~9호)', '메가커피 북한산 정릉점', '메가커피 북한산 정릉점입니다. 좋은 서비스로 모시겠습니다.', '메가커피 북한산 정릉점입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:839', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('841', '서울특별시 중랑구 중랑역로 247 (묵동)', '내일은', '내일은입니다. 좋은 서비스로 모시겠습니다.', '내일은입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:840', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('842', '서울특별시 중구 을지로 79 3동 지하1층 6호 (을지로2가)', '해뜰날', '해뜰날입니다. 좋은 서비스로 모시겠습니다.', '해뜰날입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:841', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('843', '서울특별시 중구 칠패로 46 지하1층 (봉래동1가)', '동경', '동경입니다. 좋은 서비스로 모시겠습니다.', '동경입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:842', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('844', '제주특별자치도 제주시 신대로14길 51 2층 (연동)', '옥희연동', '옥희연동입니다. 좋은 서비스로 모시겠습니다.', '옥희연동입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:843', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('845', '충청북도 청주시 상당구 수영로 285 (금천동튼튼타워 102호)', '김밥세상', '김밥세상입니다. 좋은 서비스로 모시겠습니다.', '김밥세상입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:844', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('846', '세종특별자치시 부강면 부강4길 4', '신황소꼼장어숯불구이', '신황소꼼장어숯불구이입니다. 좋은 서비스로 모시겠습니다.', '신황소꼼장어숯불구이입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:845', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('847', '충청남도 당진시 송산면 송산로 1083', '선호식당', '선호식당입니다. 좋은 서비스로 모시겠습니다.', '선호식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:846', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('848', '경기도 양주시 광적면 가래비길 46 (2층)', '주식회사 히말라야(Himalayas co.Ltd)', '주식회사 히말라야(Himalayas co.Ltd)입니다. 좋은 서비스로 모시겠습니다.', '주식회사 히말라야(Himalayas co.Ltd)입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:847', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('849', '경상남도 양산시 북안남3길 6 (북부동한양상가203호)', '원', '원입니다. 좋은 서비스로 모시겠습니다.', '원입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:848', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('850', '경상남도 거제시 동부면 거제중앙로 7 ((1층))', '해금강외도식당', '해금강외도식당입니다. 좋은 서비스로 모시겠습니다.', '해금강외도식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:849', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('851', '경상남도 거제시 거제면 거제남서로 3960 (외1필지)', '옥바우식당', '옥바우식당입니다. 좋은 서비스로 모시겠습니다.', '옥바우식당입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:850', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('852', '경상남도 김해시 진례면 평지길 294', '평지돌담집', '평지돌담집입니다. 좋은 서비스로 모시겠습니다.', '평지돌담집입니다. 좋은 서비스로 모시겠습니다.', '미국산', '10:00 - 22:851', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('853', '경상북도 울진군 죽변면 죽변중앙로 168-39', '매봉산 식당', '매봉산 식당입니다. 좋은 서비스로 모시겠습니다.', '매봉산 식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:852', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('854', '경상북도 구미시 장천면 장군로 297', '참숯마을식당', '참숯마을식당입니다. 좋은 서비스로 모시겠습니다.', '참숯마을식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:853', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('855', '경상북도 구미시 도개면 도안로 135', '일미원함바식당', '일미원함바식당입니다. 좋은 서비스로 모시겠습니다.', '일미원함바식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:854', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('856', '경상북도 안동시 제비원로 113 (당북동)', '소문난부자돼지국밥', '소문난부자돼지국밥입니다. 좋은 서비스로 모시겠습니다.', '소문난부자돼지국밥입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:855', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('857', '경상북도 경주시 충효녹지길 36-6 (충효동)', '네네치킨', '네네치킨입니다. 좋은 서비스로 모시겠습니다.', '네네치킨입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:856', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('858', '전라남도 장흥군 대덕읍 대대로 928-1', '황제삼계탕', '황제삼계탕입니다. 좋은 서비스로 모시겠습니다.', '황제삼계탕입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:857', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('859', '전라남도 순천시 우석로 104 (남정동(1층))', '천지향', '천지향입니다. 좋은 서비스로 모시겠습니다.', '천지향입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:858', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('860', '전라남도 순천시 대석3길 16-8 (연향동(1층))', '싸다아구찜&탕순천점', '싸다아구찜&탕순천점입니다. 좋은 서비스로 모시겠습니다.', '싸다아구찜&탕순천점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:859', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('861', '전라남도 여수시 시청동5길 21-1 (학동)', '회먹는날', '회먹는날입니다. 좋은 서비스로 모시겠습니다.', '회먹는날입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:860', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('862', '전라남도 목포시 원산로 63-1 (산정동)', '윤가네뒷고기', '윤가네뒷고기입니다. 좋은 서비스로 모시겠습니다.', '윤가네뒷고기입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:861', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('863', '전라북도 전주시 완산구 신촌4길 8 (중화산동2가)', '조개주인', '조개주인입니다. 좋은 서비스로 모시겠습니다.', '조개주인입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:862', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('864', '충청남도 천안시 서북구 성정5길 19 (성정동)', '토방생고기', '토방생고기입니다. 좋은 서비스로 모시겠습니다.', '토방생고기입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:863', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('865', '충청남도 천안시 동남구 충절로 202 (원성동)', '도마집', '도마집입니다. 좋은 서비스로 모시겠습니다.', '도마집입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:864', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('866', '충청북도 음성군 대소면 대동로 525', '미송숯불갈비정육점', '미송숯불갈비정육점입니다. 좋은 서비스로 모시겠습니다.', '미송숯불갈비정육점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:865', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('867', '충청북도 옥천군 군북면 소정1길 18', '문박골가든', '문박골가든입니다. 좋은 서비스로 모시겠습니다.', '문박골가든입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:866', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('868', '강원도 정선군 사북읍 사북중앙로 58-1 1층', '교촌치킨 사북고한점', '교촌치킨 사북고한점입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨 사북고한점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:867', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('869', '경기도 가평군 상면 수목원로 16 1층', '온정리 닭갈비 금강막국수(본점)', '온정리 닭갈비 금강막국수(본점)입니다. 좋은 서비스로 모시겠습니다.', '온정리 닭갈비 금강막국수(본점)입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:868', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('870', '경기도 연천군 신서면 동내로 1227', '대농쉼터', '대농쉼터입니다. 좋은 서비스로 모시겠습니다.', '대농쉼터입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:869', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('871', '경기도 하남시 신평로 35-4 (덕풍동(1층))', '대갓집 숯불갈비', '대갓집 숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '대갓집 숯불갈비입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:870', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('872', '경기도 시흥시 신현로 359 (방산동)', '행복한 밥상', '행복한 밥상입니다. 좋은 서비스로 모시겠습니다.', '행복한 밥상입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:871', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('873', '경기도 평택시 지산로 80 (지산동(지층))', '등촌샤브칼국수', '등촌샤브칼국수입니다. 좋은 서비스로 모시겠습니다.', '등촌샤브칼국수입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:872', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('874', '경기도 의정부시 녹양로 46 (가능동지상1층)', '마배식등심칼국수', '마배식등심칼국수입니다. 좋은 서비스로 모시겠습니다.', '마배식등심칼국수입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:873', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('875', '경기도 성남시 수정구 탄천로339번길 8 (사송동1층)', '황제 삼계탕 전문점', '황제 삼계탕 전문점입니다. 좋은 서비스로 모시겠습니다.', '황제 삼계탕 전문점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:874', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('876', '경기도 수원시 권선구 매송고색로 666 (고색동)', '역전할머니맥주 수원고색역점', '역전할머니맥주 수원고색역점입니다. 좋은 서비스로 모시겠습니다.', '역전할머니맥주 수원고색역점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:875', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('877', '경기도 수원시 영통구 청명남로 32 (영통동월드프라자 102호)', '사라', '사라입니다. 좋은 서비스로 모시겠습니다.', '사라입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:876', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('878', '경기도 수원시 영통구 매원로 17 (매탄동)', '뚝배기 해장국', '뚝배기 해장국입니다. 좋은 서비스로 모시겠습니다.', '뚝배기 해장국입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:877', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('879', '울산광역시 북구 호계로 284-1 (호계동 지상1층)', '피자헛울산호계점', '피자헛울산호계점입니다. 좋은 서비스로 모시겠습니다.', '피자헛울산호계점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:878', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('880', '대전광역시 서구 갈마로 184-12 (괴정동)', '토종집', '토종집입니다. 좋은 서비스로 모시겠습니다.', '토종집입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:879', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('881', '대전광역시 서구 도산로 86 1층 (도마동)', '딱좋아', '딱좋아입니다. 좋은 서비스로 모시겠습니다.', '딱좋아입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:880', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('882', '광주광역시 북구 삼정로 137 (두암동)', '한우소머리국밥', '한우소머리국밥입니다. 좋은 서비스로 모시겠습니다.', '한우소머리국밥입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:881', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('883', '광주광역시 북구 송해로 64 (일곡동2층)', '스토리', '스토리입니다. 좋은 서비스로 모시겠습니다.', '스토리입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:882', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('884', '광주광역시 서구 금화로149번길 9 103호 (금호동 호반상가)', '호반호프', '호반호프입니다. 좋은 서비스로 모시겠습니다.', '호반호프입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:883', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('885', '광주광역시 서구 상무연하로 63 (치평동 1층)', '현대옥', '현대옥입니다. 좋은 서비스로 모시겠습니다.', '현대옥입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:884', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('886', '광주광역시 서구 시청로60번길 21-9 1층 112113호 (치평동)', '크라운호프 광주상무점', '크라운호프 광주상무점입니다. 좋은 서비스로 모시겠습니다.', '크라운호프 광주상무점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:885', FALSE, TRUE, TRUE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('887', '광주광역시 서구 화정로85번길 21 1층 (쌍촌동)', '참새방앗간', '참새방앗간입니다. 좋은 서비스로 모시겠습니다.', '참새방앗간입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:886', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('888', '인천광역시 남동구 문화로89번길 19 2층 (구월동)', '더블유(W)', '더블유(W)입니다. 좋은 서비스로 모시겠습니다.', '더블유(W)입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:887', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('889', '대구광역시 달서구 선원로55길 28-16 (용산동(1층))', '북해도', '북해도입니다. 좋은 서비스로 모시겠습니다.', '북해도입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:888', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('890', '대구광역시 달서구 당산로38길 17 (두류동(지상1층))', '보배루', '보배루입니다. 좋은 서비스로 모시겠습니다.', '보배루입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:889', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('891', '대구광역시 중구 동덕로36길 48 (동인동4가)', '춘천옥', '춘천옥입니다. 좋은 서비스로 모시겠습니다.', '춘천옥입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:890', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('892', '부산광역시 기장군 기장읍 차성로288번길 32', '밀가든', '밀가든입니다. 좋은 서비스로 모시겠습니다.', '밀가든입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:891', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('893', '부산광역시 사상구 학감대로 238-30 1층 (감전동)', '손칼국수', '손칼국수입니다. 좋은 서비스로 모시겠습니다.', '손칼국수입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:892', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('894', '부산광역시 수영구 광서로 14-1 (광안동)', '오오뎅뎅', '오오뎅뎅입니다. 좋은 서비스로 모시겠습니다.', '오오뎅뎅입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:893', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('895', '부산광역시 부산진구 중앙대로 906 (양정동)', '최고당돈가스', '최고당돈가스입니다. 좋은 서비스로 모시겠습니다.', '최고당돈가스입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:894', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('896', '서울특별시 송파구 석촌호수로 216 (석촌동(10층))', '스카이 가든', '스카이 가든입니다. 좋은 서비스로 모시겠습니다.', '스카이 가든입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:895', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('897', '서울특별시 강남구 학동로41길 32 (논현동지상1층)', '해몽마포갈비', '해몽마포갈비입니다. 좋은 서비스로 모시겠습니다.', '해몽마포갈비입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:896', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('898', '서울특별시 강남구 강남대로62길 24 (역삼동지상1층)', '방파제', '방파제입니다. 좋은 서비스로 모시겠습니다.', '방파제입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:897', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('899', '서울특별시 서초구 서초대로 286 (서초동서초프라자빌딩 지하124호125호)', '교대9포차', '교대9포차입니다. 좋은 서비스로 모시겠습니다.', '교대9포차입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:898', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('900', '서울특별시 동작구 서달로 150 상가동 1층 119호 (흑석동 이랜드해가든)', '현주네김밥', '현주네김밥입니다. 좋은 서비스로 모시겠습니다.', '현주네김밥입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:899', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('901', '서울특별시 영등포구 영등포로 410 (신길동)', '부산자갈치꼼장어', '부산자갈치꼼장어입니다. 좋은 서비스로 모시겠습니다.', '부산자갈치꼼장어입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:900', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('902', '서울특별시 구로구 공원로6나길 49-2 (구로동)', '소문난토종닭도리탕 전문', '소문난토종닭도리탕 전문입니다. 좋은 서비스로 모시겠습니다.', '소문난토종닭도리탕 전문입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:901', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('903', '서울특별시 서대문구 연세로7안길 50 (창천동 지하1층)', '조커이즈(JOKER is)', '조커이즈(JOKER is)입니다. 좋은 서비스로 모시겠습니다.', '조커이즈(JOKER is)입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:902', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('904', '서울특별시 성동구 연무장7길 16 (성수동2가(지하1층))', '유진참치', '유진참치입니다. 좋은 서비스로 모시겠습니다.', '유진참치입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:903', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('905', '제주특별자치도 서귀포시 표선면 일주동로 6347-17', '소노캄제주연회장', '소노캄제주연회장입니다. 좋은 서비스로 모시겠습니다.', '소노캄제주연회장입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:904', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('906', '제주특별자치도 서귀포시 표선면 일주동로 6347-17', '셰프스키친', '셰프스키친입니다. 좋은 서비스로 모시겠습니다.', '셰프스키친입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:905', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('907', '제주특별자치도 서귀포시 표선면 일주동로 6347-17', '비비큐제주소노캄', '비비큐제주소노캄입니다. 좋은 서비스로 모시겠습니다.', '비비큐제주소노캄입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:906', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('908', '제주특별자치도 제주시 중앙로2길 31 1층 (삼도이동)', '태양상회', '태양상회입니다. 좋은 서비스로 모시겠습니다.', '태양상회입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:907', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('909', '제주특별자치도 제주시 진군4길 18 (노형동)', '그분포차', '그분포차입니다. 좋은 서비스로 모시겠습니다.', '그분포차입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:908', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('910', '경상남도 창원시 마산회원구 북성로 292-5 (회성동)', '얼큰이(회성점)', '얼큰이(회성점)입니다. 좋은 서비스로 모시겠습니다.', '얼큰이(회성점)입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:909', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('911', '경상남도 창원시 진해구 풍호로 15-1 (풍호동)', '루머커피', '루머커피입니다. 좋은 서비스로 모시겠습니다.', '루머커피입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:910', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('912', '경기도 포천시 창수면 가영로 74', '대명', '대명입니다. 좋은 서비스로 모시겠습니다.', '대명입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:911', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('913', '경기도 화성시 정남면 만년로 645', '만석한식부페', '만석한식부페입니다. 좋은 서비스로 모시겠습니다.', '만석한식부페입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:912', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('914', '경기도 화성시 정남면 만년로 472 C동 1층 일부호', '딱이야숯불닭갈비', '딱이야숯불닭갈비입니다. 좋은 서비스로 모시겠습니다.', '딱이야숯불닭갈비입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:913', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('915', '경상남도 남해군 삼동면 봉화로 2 (1029-8 번지)', '승원정', '승원정입니다. 좋은 서비스로 모시겠습니다.', '승원정입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:914', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('916', '경상남도 함안군 가야읍 중앙본길 30', '서울복집', '서울복집입니다. 좋은 서비스로 모시겠습니다.', '서울복집입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:915', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('917', '경상남도 통영시 무전대로 15 (무전동)', '임금님국밥', '임금님국밥입니다. 좋은 서비스로 모시겠습니다.', '임금님국밥입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:916', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('918', '경상북도 청도군 청도읍 고수구길 94', '대중식당', '대중식당입니다. 좋은 서비스로 모시겠습니다.', '대중식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:917', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('919', '경상북도 영덕군 남정면 산정로 117-26', '어서오리', '어서오리입니다. 좋은 서비스로 모시겠습니다.', '어서오리입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:918', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('920', '경상북도 상주시 삼백로 117 (서문동)', '안심치킨(서문점)', '안심치킨(서문점)입니다. 좋은 서비스로 모시겠습니다.', '안심치킨(서문점)입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:919', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('921', '경상북도 상주시 중앙로 185-11 (서문동)', '끼끼김밥', '끼끼김밥입니다. 좋은 서비스로 모시겠습니다.', '끼끼김밥입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:920', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('922', '경상북도 안동시 제비원로 207-1 (평화동)', '은하수식당', '은하수식당입니다. 좋은 서비스로 모시겠습니다.', '은하수식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:921', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('923', '경상북도 김천시 아포읍 한지1길 5', '띵호야반점', '띵호야반점입니다. 좋은 서비스로 모시겠습니다.', '띵호야반점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:922', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('924', '경상북도 경주시 알천북로249번길 34 (동천동)', '다샤브 경주동천점', '다샤브 경주동천점입니다. 좋은 서비스로 모시겠습니다.', '다샤브 경주동천점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:923', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('925', '경상북도 포항시 북구 법원로 25 (장성동)', '아라치치킨 장량점', '아라치치킨 장량점입니다. 좋은 서비스로 모시겠습니다.', '아라치치킨 장량점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:924', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('926', '전라남도 무안군 청계면 영산로 1693', '승달수산', '승달수산입니다. 좋은 서비스로 모시겠습니다.', '승달수산입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:925', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('927', '전라남도 여수시 봉산남4길 26-1 (봉산동)', '수연포차', '수연포차입니다. 좋은 서비스로 모시겠습니다.', '수연포차입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:926', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('928', '전라북도 정읍시 수성택지7길 16-10 (수성동)', '정읍가족감자탕', '정읍가족감자탕입니다. 좋은 서비스로 모시겠습니다.', '정읍가족감자탕입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:927', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('929', '충청남도 금산군 복수면 수영길 25-17', '나루송어장', '나루송어장입니다. 좋은 서비스로 모시겠습니다.', '나루송어장입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:928', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('930', '충청남도 공주시 번영1로 62 (신관동)', '비너스', '비너스입니다. 좋은 서비스로 모시겠습니다.', '비너스입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:929', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('931', '충청남도 천안시 서북구 성정로 82 1층 (성정동)', '김밥나라5단지점', '김밥나라5단지점입니다. 좋은 서비스로 모시겠습니다.', '김밥나라5단지점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:930', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('932', '충청북도 제천시 칠성로 54-3 (의림동)', '토기장이', '토기장이입니다. 좋은 서비스로 모시겠습니다.', '토기장이입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:931', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('933', '강원도 강릉시 하슬라로206번길 8-2 (교동)', '모닥불', '모닥불입니다. 좋은 서비스로 모시겠습니다.', '모닥불입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:932', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('934', '강원도 춘천시 백령로 65 (효자동 2동)', '투다리공대점', '투다리공대점입니다. 좋은 서비스로 모시겠습니다.', '투다리공대점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:933', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('935', '경기도 이천시 영창로 245 (창전동)', '시민칼국수', '시민칼국수입니다. 좋은 서비스로 모시겠습니다.', '시민칼국수입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:934', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('936', '경기도 파주시 한마음2길 41 (금촌동)', '황소숯불꼼장어구이', '황소숯불꼼장어구이입니다. 좋은 서비스로 모시겠습니다.', '황소숯불꼼장어구이입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:935', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('937', '경기도 파주시 황골로 69 1층 (금촌동)', '네네치킨 금촌2동점', '네네치킨 금촌2동점입니다. 좋은 서비스로 모시겠습니다.', '네네치킨 금촌2동점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:936', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('938', '경기도 용인시 처인구 모현읍 오포로 89 103호', '조개마루', '조개마루입니다. 좋은 서비스로 모시겠습니다.', '조개마루입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:937', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('939', '경기도 안산시 상록구 석호로 298 1층 (본오동)', '화평동왕냉면', '화평동왕냉면입니다. 좋은 서비스로 모시겠습니다.', '화평동왕냉면입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:938', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('940', '경기도 안산시 단원구 당곡로 9 (고잔동 530-3  진양빌딩 117118호)', '명품한우갈비살', '명품한우갈비살입니다. 좋은 서비스로 모시겠습니다.', '명품한우갈비살입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:939', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('941', '경기도 부천시 송내대로265번길 43 (상동크라운빌딩 109호)', '달토끼', '달토끼입니다. 좋은 서비스로 모시겠습니다.', '달토끼입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:940', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('942', '경기도 성남시 중원구 둔촌대로101번길 6-6 103동 102호 (성남동 삼성슈퍼빌)', '엄청난 남해아구찜', '엄청난 남해아구찜입니다. 좋은 서비스로 모시겠습니다.', '엄청난 남해아구찜입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:941', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('943', '경기도 성남시 분당구 하오개로 246 (운중동외 1필지)', '(주)맛있는상상 카페랄로점', '(주)맛있는상상 카페랄로점입니다. 좋은 서비스로 모시겠습니다.', '(주)맛있는상상 카페랄로점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:942', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('944', '경기도 수원시 장안구 장안로103번길 64 (정자동)', '원가네', '원가네입니다. 좋은 서비스로 모시겠습니다.', '원가네입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:943', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('945', '경기도 수원시 장안구 창룡대로207번길 7 (연무동)', '광교식당', '광교식당입니다. 좋은 서비스로 모시겠습니다.', '광교식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:944', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('946', '경기도 수원시 영통구 매탄로100번길 25 (매탄동)', 'BLACK 블랙', 'BLACK 블랙입니다. 좋은 서비스로 모시겠습니다.', 'BLACK 블랙입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:945', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('947', '울산광역시 울주군 범서읍 곡연2길 34', '미풍향식당', '미풍향식당입니다. 좋은 서비스로 모시겠습니다.', '미풍향식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:946', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('948', '울산광역시 중구 당산3길 17-5 (우정동)', '황금포차', '황금포차입니다. 좋은 서비스로 모시겠습니다.', '황금포차입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:947', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('949', '대전광역시 대덕구 대화로 83 1층 (대화동)', '공주칼국수쭈꾸미구이', '공주칼국수쭈꾸미구이입니다. 좋은 서비스로 모시겠습니다.', '공주칼국수쭈꾸미구이입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:948', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('950', '대전광역시 유성구 대학로159번길 25 (궁동)', '청춘블루스', '청춘블루스입니다. 좋은 서비스로 모시겠습니다.', '청춘블루스입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:949', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('951', '광주광역시 동구 동명로20번길 17-6 (동명동(1층))', '알랭', '알랭입니다. 좋은 서비스로 모시겠습니다.', '알랭입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:950', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('952', '인천광역시 남동구 매소홀로 1119 106호 (서창동 현대모닝사이드아파트상가동)', '모퉁이', '모퉁이입니다. 좋은 서비스로 모시겠습니다.', '모퉁이입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:951', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('953', '인천광역시 미추홀구 인주대로174번길 20 1층 (용현동)', '웰푸드', '웰푸드입니다. 좋은 서비스로 모시겠습니다.', '웰푸드입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:952', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('954', '대구광역시 달서구 월곡로53길 10 (상인동)', '솔내음', '솔내음입니다. 좋은 서비스로 모시겠습니다.', '솔내음입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:953', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('955', '대구광역시 동구 경대로 2 (신암동)', '뼈큰감자탕', '뼈큰감자탕입니다. 좋은 서비스로 모시겠습니다.', '뼈큰감자탕입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:954', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('956', '대구광역시 동구 파계로 71-6 (지묘동)', '가마솥식당', '가마솥식당입니다. 좋은 서비스로 모시겠습니다.', '가마솥식당입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:955', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('957', '대구광역시 중구 달구벌대로 2232 1-3층 (대봉동)', '씨제이푸드빌(주)빕스수성교점', '씨제이푸드빌(주)빕스수성교점입니다. 좋은 서비스로 모시겠습니다.', '씨제이푸드빌(주)빕스수성교점입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:956', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('958', '부산광역시 연제구 월드컵대로114번길 29 (연산동)', '술&술', '술&술입니다. 좋은 서비스로 모시겠습니다.', '술&술입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:957', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('959', '부산광역시 연제구 법원로16번길 10 (거제동)', '미조', '미조입니다. 좋은 서비스로 모시겠습니다.', '미조입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:958', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('960', '부산광역시 연제구 중앙대로 1113-1 (연산동)', '감각엔 유부', '감각엔 유부입니다. 좋은 서비스로 모시겠습니다.', '감각엔 유부입니다. 좋은 서비스로 모시겠습니다.', '호주산', '10:00 - 22:959', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('961', '부산광역시 북구 시랑로79번길 8 (구포동 금호타워 102호)', '야 다올에서놀자', '야 다올에서놀자입니다. 좋은 서비스로 모시겠습니다.', '야 다올에서놀자입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:960', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('962', '서울특별시 강남구 선릉로86길 48 (대치동지상2층)', '더 텍사스', '더 텍사스입니다. 좋은 서비스로 모시겠습니다.', '더 텍사스입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:961', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('963', '서울특별시 강서구 강서로18길 21 1층 (화곡동 8동)', '차이나 웍', '차이나 웍입니다. 좋은 서비스로 모시겠습니다.', '차이나 웍입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:962', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('964', '서울특별시 은평구 통일로85길 6-4 (갈현동)', '육회 By 유신', '육회 By 유신입니다. 좋은 서비스로 모시겠습니다.', '육회 By 유신입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:963', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('965', '서울특별시 은평구 연서로18길 3-1 지상1층 (대조동)', '구산역 옛날통닭', '구산역 옛날통닭입니다. 좋은 서비스로 모시겠습니다.', '구산역 옛날통닭입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:964', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('966', '서울특별시 노원구 공릉로 187 건설빌딩 1층 (공릉동)', '백세마인보쌈 공릉본점', '백세마인보쌈 공릉본점입니다. 좋은 서비스로 모시겠습니다.', '백세마인보쌈 공릉본점입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:965', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('967', '서울특별시 노원구 노원로34길 100 (상계동)', '명동찌개마을', '명동찌개마을입니다. 좋은 서비스로 모시겠습니다.', '명동찌개마을입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:966', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('968', '서울특별시 강북구 도봉로87길 40 (수유동)', '만복국수', '만복국수입니다. 좋은 서비스로 모시겠습니다.', '만복국수입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:967', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('969', '서울특별시 강북구 삼각산로 121-1 (수유동)', '대패상회 수유점', '대패상회 수유점입니다. 좋은 서비스로 모시겠습니다.', '대패상회 수유점입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:968', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('970', '서울특별시 강북구 삼각산로 119 1층 (수유동)', '교촌치킨', '교촌치킨입니다. 좋은 서비스로 모시겠습니다.', '교촌치킨입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:969', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('971', '서울특별시 중랑구 신내로 60 (신내동)', '그곳에가면', '그곳에가면입니다. 좋은 서비스로 모시겠습니다.', '그곳에가면입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:970', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('972', '서울특별시 성동구 아차산로7길 14-1 1층 (성수동2가 289-243)', '쭈꾸미 한판', '쭈꾸미 한판입니다. 좋은 서비스로 모시겠습니다.', '쭈꾸미 한판입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:971', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('973', '서울특별시 종로구 창신5길 15-2 (창신동)', '용궁', '용궁입니다. 좋은 서비스로 모시겠습니다.', '용궁입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:972', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('974', '서울특별시 종로구 창신3길 9 (창신동)', '수원성갈비', '수원성갈비입니다. 좋은 서비스로 모시겠습니다.', '수원성갈비입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:973', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('975', '서울특별시 종로구 종로 373 (숭인동지하1층)', '모여라', '모여라입니다. 좋은 서비스로 모시겠습니다.', '모여라입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:974', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('976', '제주특별자치도 제주시 고마로15길 4 (일도이동(인제4로8))', '쉼터', '쉼터입니다. 좋은 서비스로 모시겠습니다.', '쉼터입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:975', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('977', '충청북도 청주시 상당구 문의면 대청호반로 845-5', '마중가는길', '마중가는길입니다. 좋은 서비스로 모시겠습니다.', '마중가는길입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:976', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('978', '경상북도 칠곡군 동명면 팔공산로 165', '태백산', '태백산입니다. 좋은 서비스로 모시겠습니다.', '태백산입니다. 좋은 서비스로 모시겠습니다.', '칠레산', '10:00 - 22:977', FALSE, TRUE, FALSE, TRUE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('979', '충청북도 청주시 상당구 용암북로84번길 5-11 (용암동)', '태풍반점', '태풍반점입니다. 좋은 서비스로 모시겠습니다.', '태풍반점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:00', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('980', '경상남도 창원시 의창구 북면 천주로 1165', '울타리식당', '울타리식당입니다. 좋은 서비스로 모시겠습니다.', '울타리식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:01', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('981', '경상남도 함양군 지곡면 효산길 23-11', '시카프관광개발(주)함양(상)휴게소 우동코너', '시카프관광개발(주)함양(상)휴게소 우동코너입니다. 좋은 서비스로 모시겠습니다.', '시카프관광개발(주)함양(상)휴게소 우동코너입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:02', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('982', '경상남도 거제시 옥포대첩로6길 23 (옥포동)', '마당', '마당입니다. 좋은 서비스로 모시겠습니다.', '마당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:03', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('983', '전라남도 강진군 성전면 시천길 45', '신흥식당', '신흥식당입니다. 좋은 서비스로 모시겠습니다.', '신흥식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:04', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('984', '전라남도 여수시 여서2로 22  (여서동)', '토담민속주점', '토담민속주점입니다. 좋은 서비스로 모시겠습니다.', '토담민속주점입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:05', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('985', '전라남도 목포시 원산로59번길 31 (산정동)', '짱구아나고구이', '짱구아나고구이입니다. 좋은 서비스로 모시겠습니다.', '짱구아나고구이입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:06', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('986', '전라북도 남원시 요천로 1393-5 (천거동)', '모옥', '모옥입니다. 좋은 서비스로 모시겠습니다.', '모옥입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:07', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('987', '충청남도 서산시 대산읍 삼길포1로 161-9', '조은식당', '조은식당입니다. 좋은 서비스로 모시겠습니다.', '조은식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:08', TRUE, FALSE, FALSE, FALSE, FALSE);
INSERT INTO stores (store_num, address, store_name, detail_info, short_info, madein, opentime, parking, wifi, toilet, smokingroom, babychair) VALUES ('988', '충청북도 보은군 회남면 회남문의로 87', '록원식당', '록원식당입니다. 좋은 서비스로 모시겠습니다.', '록원식당입니다. 좋은 서비스로 모시겠습니다.', '국내산', '10:00 - 22:09', TRUE, FALSE, FALSE, FALSE, FALSE);

INSERT INTO storetypes (store_num, category_num) VALUES ('11', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('12', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('13', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('14', '27');
INSERT INTO storetypes (store_num, category_num) VALUES ('15', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('16', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('17', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('18', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('19', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('20', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('21', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('22', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('23', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('24', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('25', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('26', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('27', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('28', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('29', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('30', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('31', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('32', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('33', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('34', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('35', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('36', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('37', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('38', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('39', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('40', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('41', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('42', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('43', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('44', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('45', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('46', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('47', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('48', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('49', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('50', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('51', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('52', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('53', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('54', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('55', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('56', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('57', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('58', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('59', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('60', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('61', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('62', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('63', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('64', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('65', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('66', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('67', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('68', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('69', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('70', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('71', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('72', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('73', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('74', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('75', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('76', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('77', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('78', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('79', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('80', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('81', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('82', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('83', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('84', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('85', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('86', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('87', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('88', '24');
INSERT INTO storetypes (store_num, category_num) VALUES ('89', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('90', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('91', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('92', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('93', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('94', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('95', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('96', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('97', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('98', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('99', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('100', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('101', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('102', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('103', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('104', '29');
INSERT INTO storetypes (store_num, category_num) VALUES ('105', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('106', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('107', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('108', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('109', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('110', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('111', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('112', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('113', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('114', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('115', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('116', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('117', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('118', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('119', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('120', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('121', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('122', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('123', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('124', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('125', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('126', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('127', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('128', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('129', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('130', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('131', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('132', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('133', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('134', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('135', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('136', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('137', '12');
INSERT INTO storetypes (store_num, category_num) VALUES ('138', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('139', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('140', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('141', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('142', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('143', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('144', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('145', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('146', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('147', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('148', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('149', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('150', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('151', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('152', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('153', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('154', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('155', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('156', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('157', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('158', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('159', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('160', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('161', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('162', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('163', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('164', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('165', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('166', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('167', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('168', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('169', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('170', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('171', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('172', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('173', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('174', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('175', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('176', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('177', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('178', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('179', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('180', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('181', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('182', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('183', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('184', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('185', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('186', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('187', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('188', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('189', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('190', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('191', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('192', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('193', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('194', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('195', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('196', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('197', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('198', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('199', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('200', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('201', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('202', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('203', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('204', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('205', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('206', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('207', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('208', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('209', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('210', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('211', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('212', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('213', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('214', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('215', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('216', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('217', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('218', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('219', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('220', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('221', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('222', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('223', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('224', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('225', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('226', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('227', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('228', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('229', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('230', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('231', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('232', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('233', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('234', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('235', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('236', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('237', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('238', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('239', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('240', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('241', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('242', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('243', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('244', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('245', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('246', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('247', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('248', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('249', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('250', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('251', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('252', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('253', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('254', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('255', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('256', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('257', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('258', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('259', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('260', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('261', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('262', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('263', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('264', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('265', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('266', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('267', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('268', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('269', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('270', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('271', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('272', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('273', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('274', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('275', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('276', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('277', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('278', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('279', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('280', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('281', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('282', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('283', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('284', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('285', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('286', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('287', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('288', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('289', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('290', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('291', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('292', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('293', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('294', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('295', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('296', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('297', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('298', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('299', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('300', '27');
INSERT INTO storetypes (store_num, category_num) VALUES ('301', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('302', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('303', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('304', '28');
INSERT INTO storetypes (store_num, category_num) VALUES ('305', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('306', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('307', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('308', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('309', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('310', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('311', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('312', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('313', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('314', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('315', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('316', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('317', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('318', '12');
INSERT INTO storetypes (store_num, category_num) VALUES ('319', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('320', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('321', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('322', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('323', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('324', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('325', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('326', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('327', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('328', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('329', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('330', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('331', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('332', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('333', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('334', '2');
INSERT INTO storetypes (store_num, category_num) VALUES ('335', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('336', '13');
INSERT INTO storetypes (store_num, category_num) VALUES ('337', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('338', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('339', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('340', '28');
INSERT INTO storetypes (store_num, category_num) VALUES ('341', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('342', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('343', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('344', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('345', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('346', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('347', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('348', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('349', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('350', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('351', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('352', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('353', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('354', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('355', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('356', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('357', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('358', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('359', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('360', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('361', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('362', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('363', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('364', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('365', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('366', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('367', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('368', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('369', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('370', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('371', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('372', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('373', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('374', '14');
INSERT INTO storetypes (store_num, category_num) VALUES ('375', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('376', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('377', '14');
INSERT INTO storetypes (store_num, category_num) VALUES ('378', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('379', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('380', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('381', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('382', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('383', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('384', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('385', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('386', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('387', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('388', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('389', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('390', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('391', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('392', '14');
INSERT INTO storetypes (store_num, category_num) VALUES ('393', '14');
INSERT INTO storetypes (store_num, category_num) VALUES ('394', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('395', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('396', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('397', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('398', '14');
INSERT INTO storetypes (store_num, category_num) VALUES ('399', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('400', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('401', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('402', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('403', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('404', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('405', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('406', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('407', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('408', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('409', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('410', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('411', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('412', '14');
INSERT INTO storetypes (store_num, category_num) VALUES ('413', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('414', '15');
INSERT INTO storetypes (store_num, category_num) VALUES ('415', '15');
INSERT INTO storetypes (store_num, category_num) VALUES ('416', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('417', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('418', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('419', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('420', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('421', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('422', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('423', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('424', '15');
INSERT INTO storetypes (store_num, category_num) VALUES ('425', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('426', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('427', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('428', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('429', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('430', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('431', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('432', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('433', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('434', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('435', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('436', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('437', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('438', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('439', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('440', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('441', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('442', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('443', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('444', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('445', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('446', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('447', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('448', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('449', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('450', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('451', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('452', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('453', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('454', '28');
INSERT INTO storetypes (store_num, category_num) VALUES ('455', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('456', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('457', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('458', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('459', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('460', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('461', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('462', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('463', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('464', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('465', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('466', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('467', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('468', '15');
INSERT INTO storetypes (store_num, category_num) VALUES ('469', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('470', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('471', '15');
INSERT INTO storetypes (store_num, category_num) VALUES ('472', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('473', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('474', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('475', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('476', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('477', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('478', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('479', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('480', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('481', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('482', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('483', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('484', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('485', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('486', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('487', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('488', '12');
INSERT INTO storetypes (store_num, category_num) VALUES ('489', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('490', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('491', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('492', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('493', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('494', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('495', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('496', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('497', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('498', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('499', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('500', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('501', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('502', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('503', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('504', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('505', '15');
INSERT INTO storetypes (store_num, category_num) VALUES ('506', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('507', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('508', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('509', '16');
INSERT INTO storetypes (store_num, category_num) VALUES ('510', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('511', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('512', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('513', '16');
INSERT INTO storetypes (store_num, category_num) VALUES ('514', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('515', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('516', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('517', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('518', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('519', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('520', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('521', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('522', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('523', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('524', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('525', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('526', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('527', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('528', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('529', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('530', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('531', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('532', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('533', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('534', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('535', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('536', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('537', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('538', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('539', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('540', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('541', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('542', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('543', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('544', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('545', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('546', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('547', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('548', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('549', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('550', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('551', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('552', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('553', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('554', '16');
INSERT INTO storetypes (store_num, category_num) VALUES ('555', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('556', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('557', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('558', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('559', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('560', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('561', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('562', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('563', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('564', '16');
INSERT INTO storetypes (store_num, category_num) VALUES ('565', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('566', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('567', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('568', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('569', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('570', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('571', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('572', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('573', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('574', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('575', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('576', '25');
INSERT INTO storetypes (store_num, category_num) VALUES ('577', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('578', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('579', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('580', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('581', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('582', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('583', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('584', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('585', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('586', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('587', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('588', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('589', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('590', '28');
INSERT INTO storetypes (store_num, category_num) VALUES ('591', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('592', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('593', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('594', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('595', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('596', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('597', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('598', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('599', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('600', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('601', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('602', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('603', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('604', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('605', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('606', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('607', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('608', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('609', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('610', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('611', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('612', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('613', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('614', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('615', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('616', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('617', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('618', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('619', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('620', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('621', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('622', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('623', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('624', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('625', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('626', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('627', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('628', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('629', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('630', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('631', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('632', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('633', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('634', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('635', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('636', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('637', '16');
INSERT INTO storetypes (store_num, category_num) VALUES ('638', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('639', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('640', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('641', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('642', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('643', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('644', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('645', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('646', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('647', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('648', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('649', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('650', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('651', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('652', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('653', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('654', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('655', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('656', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('657', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('658', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('659', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('660', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('661', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('662', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('663', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('664', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('665', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('666', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('667', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('668', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('669', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('670', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('671', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('672', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('673', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('674', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('675', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('676', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('677', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('678', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('679', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('680', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('681', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('682', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('683', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('684', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('685', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('686', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('687', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('688', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('689', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('690', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('691', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('692', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('693', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('694', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('695', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('696', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('697', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('698', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('699', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('700', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('701', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('702', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('703', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('704', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('705', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('706', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('707', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('708', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('709', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('710', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('711', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('712', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('713', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('714', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('715', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('716', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('717', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('718', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('719', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('720', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('721', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('722', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('723', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('724', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('725', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('726', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('727', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('728', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('729', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('730', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('731', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('732', '17');
INSERT INTO storetypes (store_num, category_num) VALUES ('733', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('734', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('735', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('736', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('737', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('738', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('739', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('740', '20');
INSERT INTO storetypes (store_num, category_num) VALUES ('741', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('742', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('743', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('744', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('745', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('746', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('747', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('748', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('749', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('750', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('751', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('752', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('753', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('754', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('755', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('756', '1');
INSERT INTO storetypes (store_num, category_num) VALUES ('757', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('758', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('759', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('760', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('761', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('762', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('763', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('764', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('765', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('766', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('767', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('768', '20');
INSERT INTO storetypes (store_num, category_num) VALUES ('769', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('770', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('771', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('772', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('773', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('774', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('775', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('776', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('777', '29');
INSERT INTO storetypes (store_num, category_num) VALUES ('778', '20');
INSERT INTO storetypes (store_num, category_num) VALUES ('779', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('780', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('781', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('782', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('783', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('784', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('785', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('786', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('787', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('788', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('789', '29');
INSERT INTO storetypes (store_num, category_num) VALUES ('790', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('791', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('792', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('793', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('794', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('795', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('796', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('797', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('798', '29');
INSERT INTO storetypes (store_num, category_num) VALUES ('799', '29');
INSERT INTO storetypes (store_num, category_num) VALUES ('800', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('801', '20');
INSERT INTO storetypes (store_num, category_num) VALUES ('802', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('803', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('804', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('805', '29');
INSERT INTO storetypes (store_num, category_num) VALUES ('806', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('807', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('808', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('809', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('810', '22');
INSERT INTO storetypes (store_num, category_num) VALUES ('811', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('812', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('813', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('814', '22');
INSERT INTO storetypes (store_num, category_num) VALUES ('815', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('816', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('817', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('818', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('819', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('820', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('821', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('822', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('823', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('824', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('825', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('826', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('827', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('828', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('829', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('830', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('831', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('832', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('833', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('834', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('835', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('836', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('837', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('838', '22');
INSERT INTO storetypes (store_num, category_num) VALUES ('839', '22');
INSERT INTO storetypes (store_num, category_num) VALUES ('840', '22');
INSERT INTO storetypes (store_num, category_num) VALUES ('841', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('842', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('843', '24');
INSERT INTO storetypes (store_num, category_num) VALUES ('844', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('845', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('846', '24');
INSERT INTO storetypes (store_num, category_num) VALUES ('847', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('848', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('849', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('850', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('851', '12');
INSERT INTO storetypes (store_num, category_num) VALUES ('852', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('853', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('854', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('855', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('856', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('857', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('858', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('859', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('860', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('861', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('862', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('863', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('864', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('865', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('866', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('867', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('868', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('869', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('870', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('871', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('872', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('873', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('874', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('875', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('876', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('877', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('878', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('879', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('880', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('881', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('882', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('883', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('884', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('885', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('886', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('887', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('888', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('889', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('890', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('891', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('892', '24');
INSERT INTO storetypes (store_num, category_num) VALUES ('893', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('894', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('895', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('896', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('897', '24');
INSERT INTO storetypes (store_num, category_num) VALUES ('898', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('899', '12');
INSERT INTO storetypes (store_num, category_num) VALUES ('900', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('901', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('902', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('903', '24');
INSERT INTO storetypes (store_num, category_num) VALUES ('904', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('905', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('906', '25');
INSERT INTO storetypes (store_num, category_num) VALUES ('907', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('908', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('909', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('910', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('911', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('912', '20');
INSERT INTO storetypes (store_num, category_num) VALUES ('913', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('914', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('915', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('916', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('917', '6');
INSERT INTO storetypes (store_num, category_num) VALUES ('918', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('919', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('920', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('921', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('922', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('923', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('924', '26');
INSERT INTO storetypes (store_num, category_num) VALUES ('925', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('926', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('927', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('928', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('929', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('930', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('931', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('932', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('933', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('934', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('935', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('936', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('937', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('938', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('939', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('940', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('941', '25');
INSERT INTO storetypes (store_num, category_num) VALUES ('942', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('943', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('944', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('945', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('946', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('947', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('948', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('949', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('950', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('951', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('952', '29');
INSERT INTO storetypes (store_num, category_num) VALUES ('953', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('954', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('955', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('956', '25');
INSERT INTO storetypes (store_num, category_num) VALUES ('957', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('958', '4');
INSERT INTO storetypes (store_num, category_num) VALUES ('959', '9');
INSERT INTO storetypes (store_num, category_num) VALUES ('960', '20');
INSERT INTO storetypes (store_num, category_num) VALUES ('961', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('962', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('963', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('964', '11');
INSERT INTO storetypes (store_num, category_num) VALUES ('965', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('966', '5');
INSERT INTO storetypes (store_num, category_num) VALUES ('967', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('968', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('969', '25');
INSERT INTO storetypes (store_num, category_num) VALUES ('970', '21');
INSERT INTO storetypes (store_num, category_num) VALUES ('971', '25');
INSERT INTO storetypes (store_num, category_num) VALUES ('972', '30');
INSERT INTO storetypes (store_num, category_num) VALUES ('973', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('974', '27');
INSERT INTO storetypes (store_num, category_num) VALUES ('975', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('976', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('977', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('978', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('979', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('980', '3');
INSERT INTO storetypes (store_num, category_num) VALUES ('981', '8');
INSERT INTO storetypes (store_num, category_num) VALUES ('982', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('983', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('984', '10');
INSERT INTO storetypes (store_num, category_num) VALUES ('985', '23');
INSERT INTO storetypes (store_num, category_num) VALUES ('986', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('987', '7');
INSERT INTO storetypes (store_num, category_num) VALUES ('988', '7');