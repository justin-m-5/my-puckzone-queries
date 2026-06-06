-- name: get_invite_by_code
-- params: $1 = invite code
SELECT
  i.id,
  i.code,
  i.created_by,
  i.created_at,
  i.uses,
  i.max_uses,
  (i.uses < i.max_uses) AS is_redeemable
FROM public.invites AS i
WHERE i.code = $1
LIMIT 1;
