/***********************************************************************
 * Copyright 1999-2015, ALTIBASE Corporation or its subsidiaries.
 * All rights reserved.
 **********************************************************************/

CREATE PACKAGE DBMS_RECYCLEBIN AUTHID CURRENT_USER AS

PROCEDURE PURGE_USER_RECYCLEBIN;

PROCEDURE PURGE_ALL_RECYCLEBIN;

PROCEDURE PURGE_TABLESPACE( TABLESPACE_NAME IN VARCHAR(64) );

PROCEDURE PURGE_ORIGINAL_NAME( ORIGINAL_NAME IN VARCHAR(128) );

END;
/

CREATE OR REPLACE PUBLIC SYNONYM DBMS_RECYCLEBIN FOR SYS.DBMS_RECYCLEBIN;
GRANT EXECUTE ON DBMS_RECYCLEBIN TO PUBLIC;
