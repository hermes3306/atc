/** 
 *  Copyright (c) 1999~2017, Altibase Corp. and/or its affiliates. All rights reserved.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License, version 3,
 *  as published by the Free Software Foundation.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
 
/***********************************************************************
 * $Id: ilo.h 35892 2009-09-29 02:28:49Z reznoa $
 **********************************************************************/

#ifndef _O_ILO_API_H_
#define _O_ILO_API_H_

#include <time.h>

#ifdef __cplusplus
extern "C" {
#endif

#define ALTIBASE_ILOADER_V1 1

#define ALTIBASE_ILO_SUCCESS     0
#define ALTIBASE_ILO_ERROR       -1
#define ALTIBASE_ILO_WARNING     -2

typedef enum
{
    ILO_APPEND,
    ILO_REPLACE,
    ILO_TRUNCATE
} iloLoadMode;

typedef enum
{
    ILO_FALSE = 0,
    ILO_TRUE  = 1
} iloBool;

typedef enum
{
    ILO_DIRECT_NONE,   /* default NO use direct path */
    ILO_DIRECT_LOG,    /* direct path log */
    ILO_DIRECT_NOLOG   /* direct path nolog */
}iloDirectMode;

typedef enum
{
    ILO_LOG,
    ILO_STATISTIC_LOG
} ALTIBASE_ILOADER_LOG_TYPE;
typedef void * ALTIBASE_ILOADER_HANDLE;

#define ALTIBASE_ILOADER_NULL_HANDLE    NULL

typedef struct ALTIBASE_ILOADER_OPTIONS_V1
{
    int            version;            /* option version */
    char           loginID[128 * 2];   /* ����� �̸� */
    char           password[128];      /* ����� �н����� */
    char           serverName[128];    /* ���� �̸� */
    int            portNum;            /* ��Ʈ ��ȣ */
    char           NLS[128];           /* ĳ���� �� */
    char           DBName[128];        /* ����Ÿ ���̽� �̸� */
    char           tableOwner[50];     /* Ư�� ����ڿ��� ���� �ϴ� ���̺� �̸� */
    char           tableName[50];      /* ���̺� �̸� */
    char           formFile[1024];     /* ���� ���� �̸�  */
    char           dataFile[32][1024]; /* ����Ÿ ���� �̸� */
    int            dataFileNum;        /* ����Ÿ ���� ���� */
    int            firstRow;           /* ù��° ���� ��ȣ */
    int            lastRow;            /* ������ ���� ��ȣ */
    char           fieldTerm[11];      /* �ʵ� ������ ������ */
    char           rowTerm[11];        /* �� ������ ������ */
    char           enclosingChar[11];  /* �ʵ带 enclosing ��ų �� */
    iloBool        useLobFile;         /* LOB ���� ������ */
    iloBool        useSeparateFile;    /* LOB ������ ����� �� �ϳ��� LOB entry�� ���� �ϳ��� ���� */
    char           lobFileSize[11];    /* LOB ������ �ִ� ������ */
    char           lobIndicator[11];   /* LOB ������ indicator */
    iloBool        replication;        /* ����ȭ off ����Ÿ �ε� */
    iloLoadMode    loadModeType;       /* ����Ÿ ��� ���� ���� */
    char           bad[1024];          /* bad ���� �̸� */ 
    char           log[1024];          /* log ���� �̸� */
    int            splitRowCount;      /* ���� ���� ������ ���ڵ� ���� */
    int            errorCount;         /* ���� ���� */
    int            arrayCount;         /* array ���� */
    int            commitUnit;         /* commit ���� ���� */
    iloBool        atomic;             /* atomic array insert ���� ���� */
    iloDirectMode  directLog;          /* nolog, log ��� ���� */
    int            parallelCount;      /* parallel ���� ���� */
    int            readSize;           /* read size */
    iloBool        informix;           /* ������ �÷� �������� �÷� ������ �ν� */
    iloBool        flock;              /* ���� ���� lock */
    iloBool        mssql;              /* date ��� ���¸� mssql ���·� ��� */
    iloBool        getTotalRowCount;   /* ����Ÿ ������ �� ������ ���Ͽ� ���� ���� ���� */
    int            setRowFrequency;    /* �ݹ� �Լ��� ȣ�� �� row ���� ���� */ 
}ALTIBASE_ILOADER_OPTIONS_V1;

typedef struct ALTIBASE_ILOADER_ERROR
{
    int   errorCode;
    char *errorState;
    char *errorMessage;
}ALTIBASE_ILOADER_ERROR;

typedef struct ALTIBASE_ILOADER_LOG
{
    char                        tableName[50];
    int                         totalCount;
    int                         loadCount;
    int                         errorCount;
    int                         record;
    char                      **recordData;
    int                         recordColCount;
    ALTIBASE_ILOADER_ERROR      errorMgr;
}ALTIBASE_ILOADER_LOG;

typedef struct ALTIBASE_ILOADER_STATISTIC_LOG
{
    char                        tableName[50];
    time_t                      startTime;
    int                         totalCount;
    int                         loadCount;
    int                         errorCount;
}ALTIBASE_ILOADER_STATISTIC_LOG;

typedef int(*ALTIBASE_ILOADER_CALLBACK)(ALTIBASE_ILOADER_LOG_TYPE, void*);

int altibase_iloader_init( ALTIBASE_ILOADER_HANDLE *handle );

int altibase_iloader_final( ALTIBASE_ILOADER_HANDLE *handle );

int altibase_iloader_options_init( int version, void *options );

int altibase_iloader_formout( ALTIBASE_ILOADER_HANDLE *handle, 
                              int                      version,
                              void                    *options, 
                              ALTIBASE_ILOADER_ERROR  *error );

int altibase_iloader_dataout( ALTIBASE_ILOADER_HANDLE  *handle, 
                              int                       version,
                              void                     *options, 
                              ALTIBASE_ILOADER_CALLBACK logCallback,
                              ALTIBASE_ILOADER_ERROR   *error );

int altibase_iloader_datain( ALTIBASE_ILOADER_HANDLE   *handle, 
                             int                        version,
                             void                      *options, 
                             ALTIBASE_ILOADER_CALLBACK  logCallback,
                             ALTIBASE_ILOADER_ERROR     *error );


#ifdef __cplusplus
}
#endif
#endif /* _O_ILO_H_ */
