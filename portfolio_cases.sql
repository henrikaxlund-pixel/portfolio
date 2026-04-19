-- Run this in Supabase SQL Editor before deploying the portfolio
-- Dashboard > SQL Editor > New query > paste contents > Run

CREATE TABLE IF NOT EXISTS portfolio_cases (
  id            bigserial PRIMARY KEY,
  source_id     bigint NOT NULL,
  display_order integer NOT NULL DEFAULT 0,
  custom_title    text,
  custom_subtitle text,
  custom_body     text,
  cover_image     text,
  created_at    timestamptz DEFAULT now()
);

-- Allow anonymous reads (needed for index.html on GitHub Pages)
ALTER TABLE portfolio_cases ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read" ON portfolio_cases
  FOR SELECT USING (true);

-- Allow full access with the service role (used by admin.html writes)
-- Note: admin.html uses the anon key, so also grant write to anon
-- Remove this if you want to restrict writes to service role only
CREATE POLICY "Anon write" ON portfolio_cases
  FOR ALL USING (true) WITH CHECK (true);
