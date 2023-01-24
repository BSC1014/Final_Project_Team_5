CREATE TABLE "unit" (
    "id"							int		NOT NULL,
    "host_id"						int		NOT NULL,
    "booking_id"					int		NOT NULL,
    "name"							varchar(128) NULL,
    "neighbourhood_group"			varchar(128) NULL,
    "city"							varchar(128) NULL,
    "state"							varchar(128) NULL,
    "zipcode"						int		NULL,
    "latitude"						decimal	NULL,
    "longitude"						decimal	NULL,
    "property_type"					varchar(128) NULL,
    "room_type"						varchar(128) NULL,
    "accommodates"					int		NULL,
    "bathrooms"						decimal	NULL,
    "bedrooms"						int		NULL,
    "beds"							int		NULL,
    "bed_type"						varchar(128) NULL,
    "instant_bookable"				bool	NULL,
    "cancellation_policy"			varchar(128) NULL,
    "require_guest_profile_picture"	bool	NULL,
    "require_guest_phone_verification" bool	NULL,
    "number_of_reviews"				int		NULL,
    "first_review"					date	NULL,
    "last_review"					date	NULL,
    "review_scores_rating"			int		NULL,
    "review_scores_accuracy"		int		NULL,
    "review_scores_cleanliness"		int		NULL,
    "review_scores_checkin"			int		NULL,
    "review_scores_communication"	int		NULL,
    "review_scores_location"		int		NULL,
    "review_scores_value"			int		NULL,
    "reviews_per_month"				decimal	NULL,
    CONSTRAINT "pk_unit" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "host" (
    "id"					int		NOT NULL,
    "name"					varchar(128) NULL,
    "host_since"			date	NULL,
    "host_listings_count"	int		NULL,
    "host_location"			varchar(128) NULL,
    "host_response_time"	varchar(128) NULL,
    "host_response_rate"	decimal	NULL,
    "host_acceptance_rate"	int		NULL,
    "host_is_superhost"		bool	NULL,
    "host_has_profile_pic"	bool	NULL,
    "host_identity_verified" bool	NULL,
    CONSTRAINT "pk_host" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "booking" (
    "id"				int		NOT NULL,
    "price"				money	NULL,
    "weekly_price"		money	NULL,
    "monthly_price"		money	NULL,
    "guests_included"	int		NULL,
    "extra_people"		money	NULL,
    "security_deposit"	money	NULL,
    "cleaning_fee"		money	NULL,
    "min_nights"		int		NULL,
    "max_nights"		int		NULL,
    "has_availability"	bool	NULL,
    "availability_30"	int		NULL,
    "availability_60"	int		NULL,
    "availability_90"	int		NULL,
    "availability_365"	int		NULL,
    CONSTRAINT "pk_booking" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "calendar" (
    "id"				int		NOT NULL,
    "unit_id"			int 	NOT NULL,
    "date"				date	NULL,
    "available"			bool	NULL,
    "price"				money	NULL,
    CONSTRAINT "pk_calendar" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "reviews" (
    "id"				int		NOT NULL,
    "unit_id"			int 	NOT NULL,
    "date"				date	NULL,
    "reviewer_id"		int		NULL,
    "reviewer_name"		varchar(128) NULL,
    CONSTRAINT "pk_reviews" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "unit" ADD CONSTRAINT "fk_unit_host_id" FOREIGN KEY("host_id")
REFERENCES "host" ("id");

ALTER TABLE "unit" ADD CONSTRAINT "fk_unit_booking_id" FOREIGN KEY("booking_id")
REFERENCES "booking" ("id");

ALTER TABLE "calendar" ADD CONSTRAINT "fk_calendar_unit_id" FOREIGN KEY("unit_id")
REFERENCES "unit" ("id");

ALTER TABLE "reviews" ADD CONSTRAINT "fk_reviews_unit_id" FOREIGN KEY("unit_id")
REFERENCES "unit" ("id");
