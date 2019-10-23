/***********************************************************************
 * Copyright 1999-2015, ALTIBASE Corporation or its subsidiaries.
 * All rights reserved.
 **********************************************************************/

CREATE OR REPLACE PACKAGE DBMS_SHARD IS

procedure CREATE_META();

procedure SET_NODE( node_name in varchar(40),
                    host_ip in varchar(16),
                    port_no in integer,
                    alternate_host_ip in varchar(16) default NULL,
                    alternate_port_no in integer default NULL );

procedure RESET_NODE( node_name in varchar(40),
                      host_ip in varchar(16),
                      port_no in integer );

procedure RESET_ALTERNATE_NODE( node_name in varchar(40),
                                host_ip in varchar(16),
                                port_no in integer );

procedure UNSET_NODE( node_name in varchar(40) );

procedure SET_SHARD_TABLE( user_name in varchar(128),
                           table_name in varchar(128),
                           split_method in varchar(1),
                           key_column_name in varchar(128) default NULL,
                           default_node_name in varchar(40) default NULL );

procedure SET_SHARD_PROCEDURE( user_name in varchar(128),
                               proc_name in varchar(128),
                               split_method in varchar(1),
                               key_parameter_name in varchar(128) default NULL,
                               default_node_name in varchar(40) default NULL );

procedure SET_SHARD_HASH( user_name in varchar(128),
                          table_name in varchar(128),
                          hash_max in integer,
                          node_name in varchar(40) );

procedure SET_SHARD_RANGE( user_name in varchar(128),
                           table_name in varchar(128),
                           value_max in varchar(200),
                           node_name in varchar(40) );

procedure SET_SHARD_LIST( user_name  in varchar(128),
                          table_name in varchar(128),
                          value      in varchar(200),
                          node_name  in varchar(40) );

procedure SET_SHARD_CLONE( user_name in varchar(128),
                           table_name in varchar(128),
                           node_name in varchar(40) );

procedure UNSET_SHARD_TABLE( user_name in varchar(128),
                             table_name in varchar(128) );

procedure UNSET_SHARD_PROCEDURE( user_name in varchar(128),
                                 proc_name in varchar(128) );

procedure UNSET_SHARD_TABLE_BY_ID( shard_id in integer );

procedure UNSET_SHARD_PROCEDURE_BY_ID( shard_id in integer );

procedure EXECUTE_IMMEDIATE( query     in varchar(4096),
                             node_name in varchar(40) default NULL );

end dbms_shard;
/

CREATE OR REPLACE PUBLIC SYNONYM dbms_shard FOR sys.dbms_shard;
GRANT EXECUTE ON dbms_shard TO PUBLIC;

