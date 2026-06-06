-- name: get_profile_by_id
-- params: $1 = profile UUID
SELECT
  p.id,
  p.created_at,
  p.role,
  p.display_name,
  p.avatar_url,
  p.status,
  p.last_seen_at,
  p.referred_by_code,
  p.referred_by
FROM public.profiles AS p
WHERE p.id = $1
LIMIT 1;
