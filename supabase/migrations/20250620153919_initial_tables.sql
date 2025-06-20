-- Create the system_status_enum type
CREATE TYPE system_status_enum AS ENUM (
    'idle',
    'running',
    'error',
    'completed',
    'paused',
    'cancelled'
);

-- Create the system_status table
CREATE TABLE IF NOT EXISTS system_status (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL UNIQUE,
    status system_status_enum NOT NULL DEFAULT 'idle',
    description TEXT,
    updated_at TIMESTAMP DEFAULT now()
);

-- Enable row level security for the system_status table
ALTER TABLE system_status ENABLE ROW LEVEL SECURITY;

-- Seed the system_status table
INSERT INTO system_status (name, status, description)
VALUES ('scraping', 'idle', 'Initial seed for scraper status')
ON CONFLICT (name) DO NOTHING;


-- Create the companies table
CREATE TABLE companies (
    uuid UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    domain TEXT NOT NULL UNIQUE,
    linkedin_url TEXT,
    career_url TEXT,
    country TEXT,
    location TEXT,
    description TEXT,
    categories TEXT,
    status BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Enable row level security for companies
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;


-- Create the job_listings table
CREATE TABLE IF NOT EXISTS job_listings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    job_listing_url TEXT NOT NULL UNIQUE,
    job_title TEXT,
    location TEXT,
    company TEXT,
    description TEXT,
    published_date TEXT,
    application_deadline TEXT,
    no_of_vacancies TEXT,
    employment_type TEXT,
    salary TEXT,
    qualifications TEXT,
    responsibilities TEXT,
    skills TEXT,
    company_id UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
    CONSTRAINT fk_job_listings_company FOREIGN KEY (company_id) REFERENCES companies (uuid)
);

-- Enable row level security for job_listings
ALTER TABLE job_listings ENABLE ROW LEVEL SECURITY;