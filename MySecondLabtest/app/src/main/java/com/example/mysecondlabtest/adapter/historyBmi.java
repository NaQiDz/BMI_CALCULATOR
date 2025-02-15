package com.example.mysecondlabtest.adapter;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.mysecondlabtest.R;
import com.example.mysecondlabtest.model.Data;
import com.example.mysecondlabtest.viewHolder.HistoryViewHolder;

import java.util.Vector;

public class historyBmi extends RecyclerView.Adapter<HistoryViewHolder> {

    private final LayoutInflater layoutInflater;
    private final Vector<Data> data;

    public historyBmi(LayoutInflater layoutInflater, Vector<Data> datas) {
        this.layoutInflater = layoutInflater;
        this.data = datas;
    }

    @NonNull
    @Override
    public HistoryViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new HistoryViewHolder(layoutInflater.inflate(R.layout.bmi_holder, parent, false));
    }

    @Override
    public void onBindViewHolder(@NonNull HistoryViewHolder holder, int position) {
        holder.setData(data.get(position));
    }

    @Override
    public int getItemCount() {
        return data.size();
    }
}
