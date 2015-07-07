-- create_enforcement_tables.sql
-- Create draft tables for the sec enforcement project

set search_path to sec;

create table cases
(
    id serial constraint cases_pkey primary key,

    defendant_name text not null,
    defendant_type_id integer not null references defendant_types(id),
    initiation_date date not null,

    proceeding_type_id integer not null references proceedings(id),
    proceeding_id integer not null,
    
    alleged_infraction_type_id integer not null references alleged_infraction_types(id),
    relief_sought_type_id integer not null references relief_sought_types(id),
    relief_sought_value numeric,

    has_admitted_guilt boolean not null,
    is_settled_at_initiation boolean not null,
    trial_result_type_id integer references trial_result_types(id),

    distribution_fund boolean not null,
    comments text,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"(),

    unique(defendant_name, initiation_date, proceeding_id)
);

create table defendant_types
(
    id serial constraint cases_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()
);

create table proceeding_types
(
    id serial constraint cases_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()
);

create table relief_sought_types
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

create table trial_result_types
(

    id serial constraint appeals_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()

);
