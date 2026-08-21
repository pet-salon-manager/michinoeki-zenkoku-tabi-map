-- 道の駅 全国旅マップ：管理者おすすめクラウド管理
-- Supabase SQL Editor で一度だけ実行してください。

create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.recommendations (
  facility_key text primary key,
  kind text not null check (kind in ('station','rail','hotel','restaurant','tourism')),
  name text not null,
  meta text default '',
  lat double precision not null,
  lon double precision not null,
  reason text default '',
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id) on delete set null
);

alter table public.admin_users enable row level security;
alter table public.recommendations enable row level security;

drop policy if exists "admin can read own admin row" on public.admin_users;
create policy "admin can read own admin row"
on public.admin_users
for select
to authenticated
using (user_id = auth.uid());

drop policy if exists "everyone can read recommendations" on public.recommendations;
create policy "everyone can read recommendations"
on public.recommendations
for select
to anon, authenticated
using (true);

drop policy if exists "admins can insert recommendations" on public.recommendations;
create policy "admins can insert recommendations"
on public.recommendations
for insert
to authenticated
with check (
  exists (
    select 1 from public.admin_users a
    where a.user_id = auth.uid()
  )
);

drop policy if exists "admins can update recommendations" on public.recommendations;
create policy "admins can update recommendations"
on public.recommendations
for update
to authenticated
using (
  exists (
    select 1 from public.admin_users a
    where a.user_id = auth.uid()
  )
)
with check (
  exists (
    select 1 from public.admin_users a
    where a.user_id = auth.uid()
  )
);

drop policy if exists "admins can delete recommendations" on public.recommendations;
create policy "admins can delete recommendations"
on public.recommendations
for delete
to authenticated
using (
  exists (
    select 1 from public.admin_users a
    where a.user_id = auth.uid()
  )
);

-- ここから下は、Supabase Dashboard → Authentication → Users で
-- 管理者のメール/パスワードユーザーを作成したあとに1回実行します。
-- YOUR_ADMIN_EMAIL を実際の管理者メールへ置き換えてください。
--
-- insert into public.admin_users(user_id)
-- select id from auth.users
-- where email = 'YOUR_ADMIN_EMAIL'
-- on conflict (user_id) do nothing;
