PGDMP     .    -                r            d6iohidpht9rd8    9.1.11    9.1.9 9    	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            	           0    0 
   STDSTRINGS 
   STDSTRINGS     )   SET standard_conforming_strings = 'off';
                       false            	           1262    375269    d6iohidpht9rd8    DATABASE     �   CREATE DATABASE d6iohidpht9rd8 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';
    DROP DATABASE d6iohidpht9rd8;
             wskxnflqpafjnw    false                        2615    1022482    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             wskxnflqpafjnw    false            �            3079    12027    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false            	           0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    174            �            1259    1022529    conversations    TABLE     �   CREATE TABLE conversations (
    id integer NOT NULL,
    subject character varying(255) DEFAULT ''::character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
 !   DROP TABLE public.conversations;
       public         wskxnflqpafjnw    false    2280    6            �            1259    1022527    conversations_id_seq    SEQUENCE     v   CREATE SEQUENCE conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.conversations_id_seq;
       public       wskxnflqpafjnw    false    6    169            	           0    0    conversations_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE conversations_id_seq OWNED BY conversations.id;
            public       wskxnflqpafjnw    false    168            �            1259    1022518    meeting_points    TABLE       CREATE TABLE meeting_points (
    id integer NOT NULL,
    profile_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description character varying(255),
    lat numeric(10,6),
    lng numeric(10,6)
);
 "   DROP TABLE public.meeting_points;
       public         wskxnflqpafjnw    false    6            �            1259    1022516    meeting_points_id_seq    SEQUENCE     w   CREATE SEQUENCE meeting_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.meeting_points_id_seq;
       public       wskxnflqpafjnw    false    167    6            	           0    0    meeting_points_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE meeting_points_id_seq OWNED BY meeting_points.id;
            public       wskxnflqpafjnw    false    166            �            1259    1022549    notifications    TABLE     W  CREATE TABLE notifications (
    id integer NOT NULL,
    type character varying(255),
    body text,
    subject character varying(255) DEFAULT ''::character varying,
    sender_id integer,
    sender_type character varying(255),
    conversation_id integer,
    draft boolean DEFAULT false,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL,
    notified_object_id integer,
    notified_object_type character varying(255),
    notification_code character varying(255) DEFAULT NULL::character varying,
    attachment character varying(255)
);
 !   DROP TABLE public.notifications;
       public         wskxnflqpafjnw    false    2286    2287    2288    6            �            1259    1022547    notifications_id_seq    SEQUENCE     v   CREATE SEQUENCE notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.notifications_id_seq;
       public       wskxnflqpafjnw    false    6    173            	           0    0    notifications_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE notifications_id_seq OWNED BY notifications.id;
            public       wskxnflqpafjnw    false    172            �            1259    1022507    profiles    TABLE     ?  CREATE TABLE profiles (
    id integer NOT NULL,
    max_avg character varying(255),
    min_avg character varying(255),
    distance character varying(255),
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer,
    firstname character varying(255),
    lastname character varying(255),
    city character varying(255),
    lat character varying(255),
    lng character varying(255),
    start_time time without time zone,
    end_time time without time zone
);
    DROP TABLE public.profiles;
       public         wskxnflqpafjnw    false    6            �            1259    1022505    profiles_id_seq    SEQUENCE     q   CREATE SEQUENCE profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.profiles_id_seq;
       public       wskxnflqpafjnw    false    6    165            	           0    0    profiles_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE profiles_id_seq OWNED BY profiles.id;
            public       wskxnflqpafjnw    false    164            �            1259    1022538    receipts    TABLE     �  CREATE TABLE receipts (
    id integer NOT NULL,
    receiver_id integer,
    receiver_type character varying(255),
    notification_id integer NOT NULL,
    is_read boolean DEFAULT false,
    trashed boolean DEFAULT false,
    deleted boolean DEFAULT false,
    mailbox_type character varying(25),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
    DROP TABLE public.receipts;
       public         wskxnflqpafjnw    false    2282    2283    2284    6            �            1259    1022536    receipts_id_seq    SEQUENCE     q   CREATE SEQUENCE receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.receipts_id_seq;
       public       wskxnflqpafjnw    false    171    6            	           0    0    receipts_id_seq    SEQUENCE OWNED BY     5   ALTER SEQUENCE receipts_id_seq OWNED BY receipts.id;
            public       wskxnflqpafjnw    false    170            �            1259    1022484    schema_migrations    TABLE     P   CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);
 %   DROP TABLE public.schema_migrations;
       public         wskxnflqpafjnw    false    6            �            1259    1022490    users    TABLE     t  CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    failed_attempts integer DEFAULT 0,
    unlock_token character varying(255),
    locked_at timestamp without time zone,
    authentication_token character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    time_zone character varying(255),
    username character varying(255)
);
    DROP TABLE public.users;
       public         wskxnflqpafjnw    false    2273    2274    2275    2276    6            �            1259    1022488    users_id_seq    SEQUENCE     n   CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public       wskxnflqpafjnw    false    163    6            	           0    0    users_id_seq    SEQUENCE OWNED BY     /   ALTER SEQUENCE users_id_seq OWNED BY users.id;
            public       wskxnflqpafjnw    false    162            �           2604    1022532    id    DEFAULT     f   ALTER TABLE ONLY conversations ALTER COLUMN id SET DEFAULT nextval('conversations_id_seq'::regclass);
 ?   ALTER TABLE public.conversations ALTER COLUMN id DROP DEFAULT;
       public       wskxnflqpafjnw    false    168    169    169            �           2604    1022521    id    DEFAULT     h   ALTER TABLE ONLY meeting_points ALTER COLUMN id SET DEFAULT nextval('meeting_points_id_seq'::regclass);
 @   ALTER TABLE public.meeting_points ALTER COLUMN id DROP DEFAULT;
       public       wskxnflqpafjnw    false    167    166    167            �           2604    1022552    id    DEFAULT     f   ALTER TABLE ONLY notifications ALTER COLUMN id SET DEFAULT nextval('notifications_id_seq'::regclass);
 ?   ALTER TABLE public.notifications ALTER COLUMN id DROP DEFAULT;
       public       wskxnflqpafjnw    false    173    172    173            �           2604    1022510    id    DEFAULT     \   ALTER TABLE ONLY profiles ALTER COLUMN id SET DEFAULT nextval('profiles_id_seq'::regclass);
 :   ALTER TABLE public.profiles ALTER COLUMN id DROP DEFAULT;
       public       wskxnflqpafjnw    false    164    165    165            �           2604    1022541    id    DEFAULT     \   ALTER TABLE ONLY receipts ALTER COLUMN id SET DEFAULT nextval('receipts_id_seq'::regclass);
 :   ALTER TABLE public.receipts ALTER COLUMN id DROP DEFAULT;
       public       wskxnflqpafjnw    false    170    171    171            �           2604    1022493    id    DEFAULT     V   ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public       wskxnflqpafjnw    false    162    163    163            	          0    1022529    conversations 
   TABLE DATA               E   COPY conversations (id, subject, created_at, updated_at) FROM stdin;
    public       wskxnflqpafjnw    false    169    2321            	           0    0    conversations_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('conversations_id_seq', 2, true);
            public       wskxnflqpafjnw    false    168            
	          0    1022518    meeting_points 
   TABLE DATA               `   COPY meeting_points (id, profile_id, created_at, updated_at, description, lat, lng) FROM stdin;
    public       wskxnflqpafjnw    false    167    2321            	           0    0    meeting_points_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('meeting_points_id_seq', 6, true);
            public       wskxnflqpafjnw    false    166            	          0    1022549    notifications 
   TABLE DATA               �   COPY notifications (id, type, body, subject, sender_id, sender_type, conversation_id, draft, updated_at, created_at, notified_object_id, notified_object_type, notification_code, attachment) FROM stdin;
    public       wskxnflqpafjnw    false    173    2321            	           0    0    notifications_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('notifications_id_seq', 2, true);
            public       wskxnflqpafjnw    false    172            	          0    1022507    profiles 
   TABLE DATA               �   COPY profiles (id, max_avg, min_avg, distance, description, created_at, updated_at, user_id, firstname, lastname, city, lat, lng, start_time, end_time) FROM stdin;
    public       wskxnflqpafjnw    false    165    2321             	           0    0    profiles_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('profiles_id_seq', 2, true);
            public       wskxnflqpafjnw    false    164            	          0    1022538    receipts 
   TABLE DATA               �   COPY receipts (id, receiver_id, receiver_type, notification_id, is_read, trashed, deleted, mailbox_type, created_at, updated_at) FROM stdin;
    public       wskxnflqpafjnw    false    171    2321            !	           0    0    receipts_id_seq    SEQUENCE SET     6   SELECT pg_catalog.setval('receipts_id_seq', 4, true);
            public       wskxnflqpafjnw    false    170            	          0    1022484    schema_migrations 
   TABLE DATA               -   COPY schema_migrations (version) FROM stdin;
    public       wskxnflqpafjnw    false    161    2321            	          0    1022490    users 
   TABLE DATA               �  COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, failed_attempts, unlock_token, locked_at, authentication_token, created_at, updated_at, time_zone, username) FROM stdin;
    public       wskxnflqpafjnw    false    163    2321            "	           0    0    users_id_seq    SEQUENCE SET     3   SELECT pg_catalog.setval('users_id_seq', 2, true);
            public       wskxnflqpafjnw    false    162            �           2606    1022535    conversations_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.conversations DROP CONSTRAINT conversations_pkey;
       public         wskxnflqpafjnw    false    169    169    2322            �           2606    1022526    meeting_points_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY meeting_points
    ADD CONSTRAINT meeting_points_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.meeting_points DROP CONSTRAINT meeting_points_pkey;
       public         wskxnflqpafjnw    false    167    167    2322            	           2606    1022559    notifications_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public         wskxnflqpafjnw    false    173    173    2322            �           2606    1022515    profiles_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.profiles DROP CONSTRAINT profiles_pkey;
       public         wskxnflqpafjnw    false    165    165    2322            �           2606    1022546    receipts_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.receipts DROP CONSTRAINT receipts_pkey;
       public         wskxnflqpafjnw    false    171    171    2322            �           2606    1022502 
   users_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         wskxnflqpafjnw    false    163    163    2322            �           1259    1022561 &   index_notifications_on_conversation_id    INDEX     d   CREATE INDEX index_notifications_on_conversation_id ON notifications USING btree (conversation_id);
 :   DROP INDEX public.index_notifications_on_conversation_id;
       public         wskxnflqpafjnw    false    173    2322            �           1259    1022560 !   index_receipts_on_notification_id    INDEX     Z   CREATE INDEX index_receipts_on_notification_id ON receipts USING btree (notification_id);
 5   DROP INDEX public.index_receipts_on_notification_id;
       public         wskxnflqpafjnw    false    171    2322            �           1259    1022503    index_users_on_email    INDEX     G   CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);
 (   DROP INDEX public.index_users_on_email;
       public         wskxnflqpafjnw    false    163    2322            �           1259    1022504 #   index_users_on_reset_password_token    INDEX     e   CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);
 7   DROP INDEX public.index_users_on_reset_password_token;
       public         wskxnflqpafjnw    false    163    2322            �           1259    1022487    unique_schema_migrations    INDEX     Y   CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);
 ,   DROP INDEX public.unique_schema_migrations;
       public         wskxnflqpafjnw    false    161    2322            	           2606    1022567     notifications_on_conversation_id    FK CONSTRAINT     �   ALTER TABLE ONLY notifications
    ADD CONSTRAINT notifications_on_conversation_id FOREIGN KEY (conversation_id) REFERENCES conversations(id);
 X   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_on_conversation_id;
       public       wskxnflqpafjnw    false    2298    173    169    2322            	           2606    1022562    receipts_on_notification_id    FK CONSTRAINT     �   ALTER TABLE ONLY receipts
    ADD CONSTRAINT receipts_on_notification_id FOREIGN KEY (notification_id) REFERENCES notifications(id);
 N   ALTER TABLE ONLY public.receipts DROP CONSTRAINT receipts_on_notification_id;
       public       wskxnflqpafjnw    false    173    171    2304    2322            	   q   x�3�t�K+JLOU�*U)JMK+(��.QpO-*)J,MI�+҇��(8��d�q���*Y�XZ���[Z��2�a�wQ~v���������� w�8�      
	   �   x�}�Kj�0E��*��F���$k�I f�I!jk02(�n������	$�ip������ yv�#��h�;�h��T��ǔO�����Me�s#d-25�Ƃu�U��iAȯ���y�.�?��VqCA�#�!!���t}L'����9��*�$7���좪���Ю��T�aJ%�O��dɁ(O�yB]��H������r�+|�S�	(����F�(l$ PXC�8_��=gab�Yj���z5J�_���      	   �   x���=
�@F��)���aw��[i��h�]�E'L&2���e<�S�BDa``��1<%�h�٢����a�da��7HƇ_P5j_����!�b���p�)LK�<?x�;#;6w����!�˂��KH�Pη�p�_�B��EJ�BK7eҔ
����lź��e���?�3��g��CW���*�S���S���EA\Gt�]      	   �   x�eλN�0�z���5�𻤠@���f���j#�l�����)��JW���e*7��$����c$4$E���v�D�+ILz�9����ռ�rW��u�
X֖b�b�D	6:�b�����@6�N��LU-���C=��9���)���}lM��Pb��j�!��!쥢�'Ɋ�ޣ�@p���z��%�vz��Ml��&F�x�UL�G|��0|.GLp      	   s   x���1
�@��:9�^�!/3�d�����`��{�����H�>^���c�	t�\��s�~���Hjh�ԡ�A�N�tq��)B4+mt�:��-�#��rv���c�1�V��C`�?�?B�      	   g   x�]��	C1��S$�g��?G�}�B9�2X��T=T�nNB��.+�e"P7�n�s���7�6ƵY�(����4�hY����I�N��?;���1~�-|      	   =  x�}��O�@���_��k�������!�V"	RZME������D>L�2y�^~��e�o��uZ�R'ٱYj����P��G�i�5��zI,M��Bw�f;�?�o�n!���=k���a?��mk��?�8�t@:�ր<�=!()��K�@)��R�pNʵ��8'Ɓ��?�"�����)�P����+��!:��3���p@;��h�:�L�I}{mn���Bc��9�u��
��qg~��hF�i(���;y-�2x0��z�����q�d��"�?��˂P34�x<���+js*�U����차%�hF�w6a�m��<     