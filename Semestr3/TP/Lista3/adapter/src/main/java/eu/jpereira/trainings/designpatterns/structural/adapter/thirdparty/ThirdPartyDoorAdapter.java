package eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty;

import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.CodeMismatchException;
import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.IncorrectDoorCodeException;
import eu.jpereira.trainings.designpatterns.structural.adapter.model.Door;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotChangeCodeForUnlockedDoor;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotChangeStateOfLockedDoor;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotUnlockDoorException;

public class ThirdPartyDoorAdapter extends ThirdPartyDoor implements Door {


    @Override
    public void open(String code) throws IncorrectDoorCodeException {
        try{
            unlock(code);
            setState(DoorState.OPEN);
        }
        catch (CannotUnlockDoorException cannotUnlockDoorException){
            throw new IncorrectDoorCodeException();
        }
        catch (CannotChangeStateOfLockedDoor changeStateOfLockedDoor){
            throw new IncorrectDoorCodeException();
        }


    }

    @Override
    public void close() {
        try{
            setState(DoorState.CLOSED);

        } catch (CannotChangeStateOfLockedDoor changeStateOfLockedDoor) {
            changeStateOfLockedDoor.printStackTrace();
        }

    }

    @Override
    public boolean isOpen() {
        if (getState()==DoorState.OPEN){
            return true;
        }
        else{
            return false;
        }
    }

    @Override
    public void changeCode(String oldCode, String newCode, String newCodeConfirmation) throws IncorrectDoorCodeException, CodeMismatchException {

        if( ! newCode.equals(newCodeConfirmation)){
            throw new CodeMismatchException();
        }

        try {
          unlock(oldCode);
          setNewLockCode(newCode);
      }
      catch (CannotChangeCodeForUnlockedDoor | CannotUnlockDoorException cannotChangeCodeForUnlockedDoor){
            throw new IncorrectDoorCodeException();
      }
    }

    @Override
    public boolean testCode(String code) {
        try {
            unlock(code);

        } catch (CannotUnlockDoorException e) {
            return  false;
        }
        lock();

        return true;
    }
}
