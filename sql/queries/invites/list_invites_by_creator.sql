-- name: list_invites_by_creator
-- params: $1 = creator UUID
SELECT
  i.id,
  i.code,
  i.created_by,
  i.created_at,
  i.uses,
  i.max_uses
FROM public.invites AS i
WHERE i.created_by = $1
ORDER BY i.created_at DESC;
