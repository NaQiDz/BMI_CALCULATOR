package com.example.mysecondlabtest.sqlite;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import androidx.annotation.Nullable;

import com.example.mysecondlabtest.model.Data;

import java.util.ArrayList;
import java.util.List;

public class DatabaseBMI extends SQLiteOpenHelper {

    public static final String DATABASE_NAME = "bmi_db";
    public static final int DB_VERSION = 1;
    public static final String TABLE_NAME = "bmi_table";
    public static final String COL_ID = "id";
    public static final String COL_NAME = "name";
    public static final String COL_WEIGHT = "weight";
    public static final String COL_HEIGHT = "height";
    public static final String COL_BMI = "bmi";
    public static final String COL_STATUS = "status";

    public static final String createTable = "CREATE TABLE " + TABLE_NAME +
            " (" + COL_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " + COL_NAME +
            " TEXT, " + COL_WEIGHT + " REAL, " + COL_HEIGHT + " REAL, " + COL_BMI +
            " REAL, " + COL_STATUS + " TEXT)";

    public static final String dropTable = "DROP TABLE IF EXISTS " + TABLE_NAME;
    public DatabaseBMI(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    public static int insertData(Data data, Context context){
        // static methods cannot directly access instance methods or fields
        SQLiteDatabase db = new DatabaseBMI(context).getWritableDatabase(); // you need to pass context or manage instance differently
        ContentValues values = new ContentValues();
        values.put(DatabaseBMI.COL_NAME, data.getStrName());
        values.put(DatabaseBMI.COL_WEIGHT, data.getStrWeight());
        values.put(DatabaseBMI.COL_HEIGHT, data.getStrHeight());
        values.put(DatabaseBMI.COL_BMI, data.getStrBMI());
        values.put(DatabaseBMI.COL_STATUS, data.getStrStatus());
        return (int) db.insert(DatabaseBMI.TABLE_NAME, null, values);
    }

    public Data getLatestData() {
        SQLiteDatabase db = this.getReadableDatabase();
        String strSelectQuery = "SELECT * FROM " + TABLE_NAME + " ORDER BY " + COL_ID + " DESC LIMIT 1";
        Cursor cursor = db.rawQuery(strSelectQuery, null);

        if (cursor.moveToFirst()) {
            @SuppressLint("Range") String strName = cursor.getString(cursor.getColumnIndex(COL_NAME));
            @SuppressLint("Range") String strWeight = cursor.getString(cursor.getColumnIndex(COL_WEIGHT));
            @SuppressLint("Range") String strHeight = cursor.getString(cursor.getColumnIndex(COL_HEIGHT));
            @SuppressLint("Range") String strBMI = cursor.getString(cursor.getColumnIndex(COL_BMI));
            @SuppressLint("Range") String strStatus = cursor.getString(cursor.getColumnIndex(COL_STATUS));

            Data data = new Data(strName, strWeight, strHeight, strBMI, strStatus);
            cursor.close();
            return data;
        }
        cursor.close();
        return null; // Handle if no data is found
    }



    @SuppressLint("Range")
    public List<Data> getAllData(){
        List<Data> dataList = new ArrayList<Data>();
        String strSelectQuery = "SELECT * FROM " + DatabaseBMI.TABLE_NAME;
        Cursor cursor = this.getReadableDatabase().rawQuery(strSelectQuery, null);
        if(cursor.moveToFirst()){
            do{
                String strName = cursor.getString(cursor.getColumnIndex(DatabaseBMI.COL_NAME));
                String strWeight = cursor.getString(cursor.getColumnIndex(DatabaseBMI.COL_WEIGHT));
                String strHeight = cursor.getString(cursor.getColumnIndex(DatabaseBMI.COL_HEIGHT));
                String strBMI = cursor.getString(cursor.getColumnIndex(DatabaseBMI.COL_BMI));
                String strStatus = cursor.getString(cursor.getColumnIndex(DatabaseBMI.COL_STATUS));
                Data data = new Data(strName, strWeight, strHeight, strBMI, strStatus);
                dataList.add(data);
            }while (cursor.moveToNext());
            cursor.close();
        }
        return dataList;
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(createTable);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL(dropTable);
    }

}
