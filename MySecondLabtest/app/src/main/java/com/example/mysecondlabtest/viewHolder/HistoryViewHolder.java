package com.example.mysecondlabtest.viewHolder;

import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.mysecondlabtest.R;
import com.example.mysecondlabtest.model.Data;

public class HistoryViewHolder extends RecyclerView.ViewHolder {

    private final TextView lblName, lblWeight, lblHeight, lblBMI, lblStatus;
    public HistoryViewHolder(@NonNull View itemView) {
        super(itemView);
        this.lblName = itemView.findViewById(R.id.lblName);
        this.lblWeight = itemView.findViewById(R.id.lblWeight);
        this.lblHeight = itemView.findViewById(R.id.lblHeight);
        this.lblBMI = itemView.findViewById(R.id.lblBmi);
        this.lblStatus = itemView.findViewById(R.id.lblStatus);
    }

    public void setData(Data data){
        lblName.setText(data.getStrName());
        lblWeight.setText(data.getStrWeight());
        lblHeight.setText(data.getStrHeight());
        lblBMI.setText(data.getStrBMI());
        lblStatus.setText(data.getStrStatus());
    }

}
