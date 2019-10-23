/***********************************************************************
 * Copyright 1999-2015, ALTIBASE Corporation or its subsidiaries.
 * All rights reserved.
 **********************************************************************/

create or replace package body DBMS_SHARD is


-- CREATE META
procedure CREATE_META()
as
    dummy integer;
begin
    dummy := shard_create_meta();
end CREATE_META;

-- SET DATA NODE
procedure SET_NODE( node_name in varchar(40),
                    host_ip in varchar(16),
                    port_no in integer,
                    alternate_host_ip in varchar(16) default NULL,
                    alternate_port_no in integer default NULL )
as
    dummy integer;
    up_node_name varchar(40);
begin
    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_set_node(up_node_name, host_ip, port_no, alternate_host_ip, alternate_port_no);
end SET_NODE;

-- RESET DATA NODE
procedure RESET_NODE( node_name in varchar(40),
                      host_ip in varchar(16),
                      port_no in integer )
as
    dummy integer;
    up_node_name varchar(40);
begin
    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_reset_node(up_node_name, host_ip, port_no, 0);
end RESET_NODE;

-- RESET ALTERNATE DATA NODE
procedure RESET_ALTERNATE_NODE( node_name in varchar(40),
                                host_ip in varchar(16),
                                port_no in integer )
as
    dummy integer;
    up_node_name varchar(40);
begin
    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_reset_node(up_node_name, host_ip, port_no, 1);
end RESET_ALTERNATE_NODE;

-- UNSET DATA NODE
procedure UNSET_NODE( node_name in varchar(40) )
as
    dummy integer;
    up_node_name varchar(40);
begin
    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_unset_node( up_node_name );
end UNSET_NODE;

-- SET SHARD TABLE INFO
procedure SET_SHARD_TABLE( user_name in varchar(128),
                           table_name in varchar(128),
                           split_method in varchar(1),
                           key_column_name in varchar(128) default NULL,
                           default_node_name in varchar(40) default NULL )
as
    dummy integer;
    up_user_name varchar(128);
    up_table_name varchar(128);
    up_split_method varchar(1);
    up_key_column_name varchar(128);
    up_default_node_name varchar(40);
begin
    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( table_name, chr(34) ) = 0 then
        up_table_name := upper( table_name );
    else
        up_table_name := replace2( table_name, chr(34) );
    end if;

    up_split_method := upper( split_method );

    if instr( key_column_name, chr(34) ) = 0 then
        up_key_column_name := upper( key_column_name );
    else
        up_key_column_name := replace2( key_column_name, chr(34) );
    end if;

    if instr( default_node_name, chr(34) ) = 0 then
        up_default_node_name := upper( default_node_name );
    else
        up_default_node_name := replace2( default_node_name, chr(34) );
    end if;

    dummy := shard_set_shard_table( up_user_name,
                                    up_table_name,
                                    up_split_method,
                                    up_key_column_name,
                                    up_default_node_name );
end SET_SHARD_TABLE;

-- SET SHARD PROCEDURE INFO
procedure SET_SHARD_PROCEDURE( user_name in varchar(128),
                               proc_name in varchar(128),
                               split_method in varchar(1),
                               key_parameter_name in varchar(128) default NULL,
                               default_node_name in varchar(40) default NULL )
as
    dummy integer;
    up_user_name varchar(128);
    up_proc_name varchar(128);
    up_split_method varchar(1);
    up_key_parameter_name varchar(128);
    up_default_node_name varchar(40);
begin
    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( proc_name, chr(34) ) = 0 then
        up_proc_name := upper( proc_name );
    else
        up_proc_name := replace2( proc_name, chr(34) );
    end if;

    up_split_method := upper( split_method );

    if instr( key_parameter_name, chr(34) ) = 0 then
        up_key_parameter_name := upper( key_parameter_name );
    else
        up_key_parameter_name := replace2( key_parameter_name, chr(34) );
    end if;

    if instr( default_node_name, chr(34) ) = 0 then
        up_default_node_name := upper( default_node_name );
    else
        up_default_node_name := replace2( default_node_name, chr(34) );
    end if;

    dummy := shard_set_shard_procedure( up_user_name,
                                        up_proc_name,
                                        up_split_method,
                                        up_key_parameter_name,
                                        up_default_node_name );
end SET_SHARD_PROCEDURE;

-- SET SHARD HASH
procedure SET_SHARD_HASH( user_name in varchar(128),
                          table_name in varchar(128),
                          hash_max in integer,
                          node_name in varchar(40) )
as
    dummy integer;
    up_user_name varchar(128);
    up_table_name varchar(128);
    up_node_name varchar(40);

begin

    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( table_name, chr(34) ) = 0 then
        up_table_name := upper( table_name );
    else
        up_table_name := replace2( table_name, chr(34) );
    end if;

    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_set_shard_hash( up_user_name,
                                   up_table_name,
                                   hash_max,
                                   up_node_name );
end SET_SHARD_HASH;

-- SET SHARD RANGE
procedure SET_SHARD_RANGE( user_name in varchar(128),
                           table_name in varchar(128),
                           value_max in varchar(200),
                           node_name in varchar(40) )
as
    dummy integer;
    up_user_name varchar(128);
    up_table_name varchar(128);
    up_node_name varchar(40);

begin

    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( table_name, chr(34) ) = 0 then
        up_table_name := upper( table_name );
    else
        up_table_name := replace2( table_name, chr(34) );
    end if;

    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_set_shard_range( up_user_name,
                                    up_table_name,
                                    value_max,
                                    up_node_name );
end SET_SHARD_RANGE;

-- SET SHARD LIST
procedure SET_SHARD_LIST( user_name  in varchar(128),
                          table_name in varchar(128),
                          value      in varchar(200),
                          node_name  in varchar(40) )
as
    dummy integer;
    up_user_name varchar(128);
    up_table_name varchar(128);
    up_node_name varchar(40);

begin

    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( table_name, chr(34) ) = 0 then
        up_table_name := upper( table_name );
    else
        up_table_name := replace2( table_name, chr(34) );
    end if;

    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_set_shard_list( up_user_name,
                                   up_table_name,
                                   value,
                                   up_node_name );
end SET_SHARD_LIST;

-- SET SHARD CLONE
procedure SET_SHARD_CLONE( user_name in varchar(128),
                           table_name in varchar(128),
                           node_name in varchar(40) )
as
    dummy integer;
    up_user_name varchar(128);
    up_table_name varchar(128);
    up_node_name varchar(40);

begin

    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( table_name, chr(34) ) = 0 then
        up_table_name := upper( table_name );
    else
        up_table_name := replace2( table_name, chr(34) );
    end if;

    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_set_shard_clone( up_user_name,
                                    up_table_name,
                                    up_node_name );
end SET_SHARD_CLONE;

-- UNSET SHARD TABLE
procedure UNSET_SHARD_TABLE( user_name in varchar(128),
                             table_name in varchar(128) )
as
    dummy integer;
    up_user_name varchar(128);
    up_table_name varchar(128);

begin
    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( table_name, chr(34) ) = 0 then
        up_table_name := upper( table_name );
    else
        up_table_name := replace2( table_name, chr(34) );
    end if;

    dummy := shard_unset_shard_table( up_user_name, up_table_name );
end UNSET_SHARD_TABLE;

-- UNSET SHARD PROCEDURE
procedure UNSET_SHARD_PROCEDURE( user_name in varchar(128),
                                 proc_name in varchar(128) )
as
    dummy integer;
    up_user_name varchar(128);
    up_proc_name varchar(128);

begin
    if instr( user_name, chr(34) ) = 0 then
        up_user_name := upper( user_name );
    else
        up_user_name := replace2( user_name, chr(34) );
    end if;

    if instr( proc_name, chr(34) ) = 0 then
        up_proc_name := upper( proc_name );
    else
        up_proc_name := replace2( proc_name, chr(34) );
    end if;

    dummy := shard_unset_shard_procedure( up_user_name, up_proc_name );
end UNSET_SHARD_PROCEDURE;

-- UNSET SHARD TABLE BY ID
procedure UNSET_SHARD_TABLE_BY_ID( shard_id in integer )
as
    dummy integer;
begin
    dummy := shard_unset_shard_table_by_id( shard_id );
end UNSET_SHARD_TABLE_BY_ID;

-- UNSET SHARD PROCEDURE BY ID
procedure UNSET_SHARD_PROCEDURE_BY_ID( shard_id in integer )
as
    dummy integer;
begin
    dummy := shard_unset_shard_procedure_by_id( shard_id );
end UNSET_SHARD_PROCEDURE_BY_ID;

-- EXECUTE ADHOC QUERY
procedure EXECUTE_IMMEDIATE( query     in varchar(4096),
                             node_name in varchar(40) default NULL )
as
    dummy integer;
    up_node_name varchar(40);
begin
    if instr( node_name, chr(34) ) = 0 then
        up_node_name := upper( node_name );
    else
        up_node_name := replace2( node_name, chr(34) );
    end if;

    dummy := shard_execute_immediate( query, up_node_name );
end EXECUTE_IMMEDIATE;


end DBMS_SHARD;
/
