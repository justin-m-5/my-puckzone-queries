-- name: get_profile_with_referrer
-- params: $1 = profile UUID
SELECT
  p.id,
  p.display_name,
  p.avatar_url,
  p.status,
  p.referred_by_code,
  p.referred_by,
  r.id AS referrer_id,
  r.display_name AS referrer_display_name,
  r.avatar_url AS referrer_avatar_url
FROM public.profiles AS p
LEFT JOIN public.profiles AS r
  ON r.id = p.referred_by
WHERE p.id = $1
LIMIT 1;
