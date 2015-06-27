-- create_enforcement_tables.sql
-- Create draft tables for the sec enforcement project

set search_path to sec;

create table cases
(
    id integer primary key default nextval('serial'),

    defendant_name text not null,
    defendant_type_id integer not null references defendant_types(id),
    initiation_date date not null,
    court_or_ap_ref integer not null references court_or_ap_ref(id),
    relief_sought text not null,
    guilt_admitted boolean not null,
    is_settled_at_initiation boolean not null,
    trial_result_type_id integer not null references trial_result_types(id),
    distribution_fund,
    comments text

    created_at timestamp,
    updated_at timestamp,
    updated_by timestamp
);

create table citations
(
    id integer primary key default nextval('serial'),

    case_id integer not null references cases(id)

);

create table defendant_lawyers
(
    id integer primary key default nextval('serial'),

    lawyer_name text not null,
    case_id integer not null references cases(id)

);

create table appeals
(
    id integer primary key default nextval('serial'),

    case_id integer not null references cases(id),
    trial_result_type_id integer not null references trial_result_types(id)
        

);
