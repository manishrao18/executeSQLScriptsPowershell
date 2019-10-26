SELECT DISTINCT sysObj.id, sysObj.name AS 'Procedure_Name', sysOObj.name AS 'Table_Name', sysD.depid
--, sysD.depnumber  -- comment to return unique tables only
FROM sysdepends sysD, sysobjects sysObj, sysobjects sysOObj
WHERE sysObj.id = sysD.id
AND sysObj.name IN('GETDEMOGRAPHICS')  -- Stored Procedure Name
AND sysOObj.id = sysD.depid --and depnumber=1
ORDER BY sysObj.name,sysOObj.name

