package com.ssu385.blizzardconsumer.boss.viewcontroller.fragment;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.ssu385.blizzardconsumer.R;
import com.ssu385.blizzardconsumer.boss.interactor.BossInteractor;
import com.ssu385.blizzardconsumer.boss.interactor.BossListInteractor;
import com.ssu385.blizzardconsumer.boss.interactor.BossListInteractorMock;
import com.ssu385.blizzardconsumer.boss.presenter.BossPresenter;
import com.ssu385.blizzardconsumer.boss.view.BossView;
import com.ssu385.blizzardconsumer.boss.viewcontroller.adapter.BossListAdapter;
import com.ssu385.blizzardconsumer.core.model.Boss;


/*
    Fragment built to display list of Boss data. Implements the BossView for loos coupling
    with the BossPresenter.
 */
public class BossListFragment extends Fragment implements BossView {

    // private member variables
    private BossPresenter presenter;
    private BossInteractor interactor;
    private RecyclerView bossListRecycler;
    private LinearLayoutManager linearLayoutManager;

    private OnFragmentInteractionListener mListener;

    public BossListFragment() {
        // Required empty public constructor
    }


    public static BossListFragment newInstance() {
        BossListFragment fragment = new BossListFragment();
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // instantiated the BossInteractor as the BossListInteractorMock
        interactor = new BossListInteractorMock();
        // interactor = new BossListInteractor();

        // instantiating presenter with concretely instantiated dependencies
        presenter = new BossPresenter(this, interactor);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_boss_list, container, false);

        // Contextual link to RecyclerView element declared in the fragment_boss_list fragment
        bossListRecycler = (RecyclerView)view.findViewById(R.id.boss_recycler_view);
        // Create a layout manager for the RecyclerView to define layout type
        linearLayoutManager = new LinearLayoutManager(this.getActivity().getBaseContext());
        // Set the LayoutManager on the RecyclerView
        bossListRecycler.setLayoutManager(linearLayoutManager);
        // Call the BossPresenter to retrieve the data
        presenter.presentBossData(null);

        return view;
    }


    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    // Handle the results as presented to the View by the Presenter
    @Override
    public void displayBossViewData(Boss... bosses) {
        BossListAdapter adapter = new BossListAdapter(bosses);

        bossListRecycler.setAdapter(adapter);

    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
}
