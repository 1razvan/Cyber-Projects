import abc, configparser
import psycopg2
from psycopg2.extras import DictCursor


class Sqlpostgres:

    def __init__(self):
        config = configparser.ConfigParser()
        config.read('db.ini')

        config_dict = {}
        config_dict['postgres'] = {}

        for section in config.sections():
            config_dict[section] = {}
            for key,val in config.items(section):
                config_dict[section][key] = val
        
        host = config_dict['postgres']['host']
        user = config_dict['postgres']['user']
        password = config_dict['postgres']['password']
        db = config_dict['postgres']['db']
        
        self._conn = psycopg2.connect(database=db, user=user, host='localhost', password=password)
        
    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

    @property
    def connect(self):
        return self._conn


    def commit(self):
        self._conn.commit()

    def close(self, commit=True):
        if commit:
            self.commit()
        self._conn.close()

    def execute(self, sql):
        with self._conn.cursor() as cur:
            cur.execute(sql)

    def query(self, sql, params=None):
        with self._conn.cursor(cursor_factory=DictCursor) as cur:
            cur.execute(sql, params or ())
            records = cur.fetchall()
        cur.close()
        return records

    def querysingle(self, sql, params=None):
        with self._conn.cursor(cursor_factory=DictCursor) as cur:
            cur.execute(sql, params or ())
            record = cur.fetchone()
        cur.close()
        return record

    def querysearch(self, sql):
        with self._conn.cursor(cursor_factory=DictCursor) as cur:
            cur.execute(sql)
            records = cur.fetchall()
        cur.close()
        return records