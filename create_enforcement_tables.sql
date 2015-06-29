-- create_enforcement_tables.sql
-- Create draft tables for the sec enforcement project

set search_path to sec;

create table cases
(
    id serial constraint cases_pkey primary key,

    defendant_name text not null,
    defendant_type_id integer not null references defendant_types(id),
    initiation_date date not null,

    -- Do all courts or proceedings have a unique reference or does it require another table?
    court_or_ap_ref integer not null references court_or_ap_ref(id),

    -- Is this usually money?  How do you want to encode it? Number?
    relief_sought text not null,
    has_admitted_guilt boolean not null,
    is_settled_at_initiation boolean not null,
    trial_result_type_id integer not null references trial_result_types(id),

    -- What is the distribution fund?
    distribution_fund text,
    comments text,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"(),

    unique(defendant_name, initiation_date, court_or_ap_ref)
);

create table defendant_types
(
    id serial constraint cases_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()
);

-- What does a citation look like?
create table citations
(
    id serial constraint citations_pkey primary key,
    case_id integer not null references cases(id),

    citation_type_id integer not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()

);

create table citation_types
(
    id serial constraint citations_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()
);

create table defendant_lawyers
(
    id serial constraint defendant_lawyers_pkey primary key,
    case_id integer not null references cases(id),

    lawyer_name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()
);

create table appeals
(
    id serial constraint appeals_pkey primary key,
    case_id integer not null references cases(id),

    trial_result_type_id integer not null references trial_result_types(id),

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()

);

create table trial_results_types
(

    id serial constraint appeals_pkey primary key,
    case_id integer not null references cases(id),

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()

);
