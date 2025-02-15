package com.example.expensestracker.adapter;


import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.BaseAdapter;

import com.example.expensestracker.R;
import com.example.expensestracker.model.Expense;
import com.example.expensestracker.model.User;

import java.util.ArrayList;

public class ExpenseAdapterList extends BaseAdapter {
    private Context context;
    private ArrayList<Expense> expenseList;

    public ExpenseAdapterList(Context context, ArrayList<Expense> expenseList) {
        this.context = context;
        this.expenseList = expenseList;
    }

    @Override
    public int getCount() { return expenseList.size(); }

    @Override
    public Object getItem(int position) { return expenseList.get(position); }

    @Override
    public long getItemId(int position) { return position; }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater.from(context).inflate(R.layout.list_expense_item, parent, false);
        }

        TextView textDescription = convertView.findViewById(R.id.textDescription);
        TextView textAmount = convertView.findViewById(R.id.textAmount);
        TextView textCategory = convertView.findViewById(R.id.textCategory);
        TextView textDate = convertView.findViewById(R.id.textDate);
        TextView textUserId = convertView.findViewById(R.id.textUserId);

        Expense expense = expenseList.get(position);
        textDescription.setText("Description: " + expense.getDescription());
        textAmount.setText("Amount: " + expense.getAmount());
        textCategory.setText("Category: " + expense.getCategory());
        textDate.setText("Date: " + expense.getDate());
        textUserId.setText("User ID: " + expense.getUserId());


        return convertView;
    }
}

