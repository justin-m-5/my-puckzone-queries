-- name: list_profiles
-- params: $1 = max rows to return, $2 = rows to skip (offset)
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
ORDER BY p.created_at DESC
LIMIT $1 OFFSET $2;
