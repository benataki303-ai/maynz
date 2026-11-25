-- MAYNZ: exécuter ce script dans Supabase > SQL Editor
create table if not exists public.menu_items (
  id text primary key,
  category text not null check (category in ('tabouna','mlawi','ma9loub','baguette')),
  name_fr text not null,
  name_ar text not null,
  price numeric(7,3) not null check (price >= 0),
  sort_order integer not null default 0
);

alter table public.menu_items enable row level security;

drop policy if exists "Public can read menu" on public.menu_items;
create policy "Public can read menu" on public.menu_items
for select to anon, authenticated using (true);

create table if not exists public.maynz_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.maynz_admins enable row level security;

drop policy if exists "Admins can read own admin record" on public.maynz_admins;
create policy "Admins can read own admin record" on public.maynz_admins
for select to authenticated using (auth.uid() = user_id);

drop policy if exists "Only admins can update menu" on public.menu_items;
create policy "Only admins can update menu" on public.menu_items
for update to authenticated
using (exists (select 1 from public.maynz_admins a where a.user_id = auth.uid()))
with check (exists (select 1 from public.maynz_admins a where a.user_id = auth.uid()));

insert into public.menu_items(id,category,name_fr,name_ar,price,sort_order) values
('t1','tabouna','Tabouna Thon','طابونة تن',5.500,1),
('t2','tabouna','Tabouna Escalope','طابونة إسكالوب',6.500,2),
('t3','tabouna','Tabouna Chawarma','طابونة شورمة',6.500,3),
('t4','tabouna','Tabouna Escalope panée','طابونة إسكالوب باني',7.000,4),
('m1','mlawi','Mlawi Thon','ملاوي تن',6.000,5),
('m2','mlawi','Mlawi Escalope','ملاوي إسكالوب',7.000,6),
('m3','mlawi','Mlawi Chawarma','ملاوي شورمة',7.000,7),
('m4','mlawi','Mlawi Escalope panée','ملاوي إسكالوب باني',8.000,8),
('l1','ma9loub','Ma9loub Thon','مقلوب تن',7.000,9),
('l2','ma9loub','Ma9loub Escalope ou Chawarma','مقلوب إسكالوب أو شورمة',8.000,10),
('l3','ma9loub','Ma9loub Escalope panée','مقلوب إسكالوب باني',9.000,11),
('b1','baguette','Baguette farcie Thon, Escalope ou Chawarma','باغيت محشية تن أو إسكالوب أو شورمة',8.500,12),
('b2','baguette','Baguette farcie Escalope panée','باغيت محشية إسكالوب باني',9.000,13)
on conflict (id) do update set category=excluded.category,name_fr=excluded.name_fr,name_ar=excluded.name_ar,price=excluded.price,sort_order=excluded.sort_order;
