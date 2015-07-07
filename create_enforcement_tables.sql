-- create_enforcement_tables.sql
-- Create draft tables for the sec enforcement project
-- Core layout: each set of defendants under SEC prosecution for an alleged infraction on a given
-- initiation date constitutes a case.  Each instance of a case being heard is a trial.

set search_path to sec;

create table cases
(
    id serial constraint cases_pkey primary key,

    defendant_name text not null,
    defendant_type_id integer not null references defendant_types(id),
    initiation_date date not null,

    case_identifier text not null,

    proceeding_type_id integer not null references proceeding_types(id),
    alleged_infraction_type_id integer not null references alleged_infraction_types(id),
    relief_sought_type_id integer not null references relief_sought_types(id),
    relief_sought_value numeric,

    has_admitted_guilt boolean not null,
    is_settled_at_initiation boolean not null,

    distribution_fund boolean not null,
    comments text,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"(),

    unique(case_identifier)
);

-- Not all cases make it to court and since some have appeals, there can be more than one court
-- event per case.
create table court_cases
(
    id serial constraint cases_pkey primary key,

    case_id integer not null references cases(id),
    court_id integer not null references courts(id),

    court_case_identifier integer not null,
    trial_result_type_id integer references trial_result_types(id),

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()

);

-- The court in which a case is heard matters for identification
create table courts
(
    id serial constraint cases_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"(),

    unique(name)
);

-- So that we can categorize defendants, i.e. firms or individuals
create table defendant_types
(
    id serial constraint cases_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()
);

-- There is often more than one defendant per case
create table defendants
(
    id serial constraint cases_pkey primary key,

    name text not null,

    case_id integer not null references cases(id),

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"(),

    unique(name, case_id)
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
    court_case_id integer not null references court_cases(id),

    citation text not null,

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

create table trial_result_types
(

    id serial constraint appeals_pkey primary key,

    name text not null,

    created_at timestamp not null default now(),
    updated_at timestamp not null default now(),
    updated_by text not null default "current_user"()

);
