create table habit_data (
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  key text not null,
  value jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);
alter table habit_data enable row level security;
create policy "own rows only" on habit_data for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
