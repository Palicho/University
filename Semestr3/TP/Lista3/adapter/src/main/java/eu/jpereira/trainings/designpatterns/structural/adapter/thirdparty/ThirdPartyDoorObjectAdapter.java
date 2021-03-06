package eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty;

import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.CodeMismatchException;
import eu.jpereira.trainings.designpatterns.structural.adapter.exceptions.IncorrectDoorCodeException;
import eu.jpereira.trainings.designpatterns.structural.adapter.model.Door;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotChangeCodeForUnlockedDoor;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotChangeStateOfLockedDoor;
import eu.jpereira.trainings.designpatterns.structural.adapter.thirdparty.exceptions.CannotUnlockDoorException;

public class ThirdPartyDoorObjectAdapter implements Door {


    private ThirdPartyDoor door = new ThirdPartyDoor();

    @Override
    public void open(String code) throws IncorrectDoorCodeException {
        try{
            door.unlock(code);
            door.setState(ThirdPartyDoor.DoorState.OPEN);
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
            door.setState(ThirdPartyDoor.DoorState.CLOSED);

        } catch (CannotChangeStateOfLockedDoor changeStateOfLockedDoor) {
            changeStateOfLockedDoor.printStackTrace();
        }

    }

    @Override
    public boolean isOpen() {
        if (door.getState()== ThirdPartyDoor.DoorState.OPEN){
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
            door.unlock(oldCode);
            door.setNewLockCode(newCode);
        }
        catch (CannotChangeCodeForUnlockedDoor | CannotUnlockDoorException cannotChangeCodeForUnlockedDoor){
            throw new IncorrectDoorCodeException();
        }
    }

    @Override
    public boolean testCode(String code) {
        try {
            door.unlock(code);

        } catch (CannotUnlockDoorException e) {
            return  false;
        }
        door.lock();

        return true;
    }
}
